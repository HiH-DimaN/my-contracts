
/* --- Пункт 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

// Импортируем интерфейс ERC20 из OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


/**
 * @title MyERC20
 * @dev Базовая реализация стандарта ERC20.
 */
abstract contract MyERC20 is IERC20, Ownable {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /**
     * @dev Событие, возникающее при переводе токенов.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param value Количество переведенных токенов.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Событие, возникающее при установлении разрешения на перевод.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешен перевод.
     * @param value Количество токенов, на которые разрешен перевод.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Конструктор.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество десятичных знаков.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    /**
     * @dev Возвращает имя токена.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Возвращает символ токена.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Возвращает количество десятичных знаков.
     */
    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    /**
     * @dev Возвращает общее количество токенов.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Возвращает баланс адреса.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Переводит токены на адрес.
     * 
     * Требования:
     * - Баланс отправителя должен быть не меньше `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev Возвращает остаток разрешенного количества токенов, которые
     * `spender` может потратить от имени `owner`.
     *
     * Это значение изменяется при вызове {approve} или {transferFrom}
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev Устанавливает разрешение `spender` тратить токены от имени `owner` до `amount`.
     *
     * Эмиттирует событие {Approval}.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev Увеличивает разрешение `spender` тратить токены от имени `owner` на `addedValue`.
     *
     * Эмиттирует событие {Approval}.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 newAllowance = allowance(owner, spender) + addedValue;
        _approve(owner, spender, allowance(owner, spender) + addedValue); // Вызов _approve для эмиттирования Approval
        return true;
    }

    /**
     * @dev Переводит `amount` токенов от `sender` к `recipient`, используя разрешение.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - `sender` должен иметь баланс не меньше `amount`.
     * - `spender` должен иметь разрешение не меньше `amount` от `sender`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(sender, spender, amount);
        _transfer(sender, recipient, amount);
        return true;
    }

    /**
     * @dev Переводит токены от `from` к `to`.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - `from` должен иметь баланс не меньше `amount`.
     * - `to` не должен быть нулевым адресом.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Создает `amount` токенов и присваивает их `account`, увеличивая
     * общее предложение.
     *
     * Эмиттирует событие {Transfer} с `from` установленным в нулевой адрес.
     *
     * Требования:
     *
     * - `account` не должен быть нулевым адресом.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Сжигает `amount` токенов от `account`, уменьшая
     * общее предложение.
     *
     * Эмиттирует событие {Transfer} с `to` установленным в нулевой адрес.
     *
     * Требования:
     *
     * - `account` не должен быть нулевым адресом.
     * - `account` должен иметь баланс не меньше `amount`.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Устанавливает `amount` как разрешение `spender` тратить токены от имени `owner`.
     *
     * Эмиттирует событие {Approval}.
     *
     * Требования:
     *
     * - `owner` не должен быть нулевым адресом.
     * - `spender` не должен быть нулевым адресом.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Уменьшает разрешение `spender` тратить токены от имени `owner` на `subtractedValue`.
     *
     * Требования:
     *
     * - `spender` должен иметь разрешение не меньше `subtractedValue` от `owner`.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 subtractedValue
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: insufficient allowance");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }
    }

    /**
     * @dev Hook, который вызывается перед любым переводом токенов. Это включает в себя
     * минт и сжигание.
     *
     * Calling conditions:
     *
     * - Когда `from` и `to` не являются нулевыми адресами, `amount` токенов будет переведено от `from` к `to`.
     * - Когда `from` - нулевой адрес, `amount` токенов будет создано для `to`.
     * - Когда `to` - нулевой адрес, `amount` токенов будет сожжено от `from`.
     * - `from` и `to` - никогда не будут одновременно нулевыми адресами.
     *
     * Чтобы узнать больше о том, как перехватить события передачи токенов, см. {IERC20-beforeTokenTransfer}.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        // Выполнить проверки или действия, например:
        // - Проверить, не находится ли `from` в черном списке
        // - Обновить данные, связанные с балансами
        // ... 
    }

    /**
     * @dev Hook, который вызывается после любого перевода токенов. Это включает в себя
     * минт и сжигание.
     *
     * Calling conditions:
     *
     * - Когда `from` и `to` не являются нулевыми адресами, `amount` токенов было переведено от `from` к `to`.
     * - Когда `from` - нулевой адрес, `amount` токенов было создано для `to`.
     * - Когда `to` - нулевой адрес, `amount` токенов было сожжено от `from`.
     * - `from` и `to` - никогда не будут одновременно нулевыми адресами.
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual override {
        // Выполнить какие-то действия, например:
        // - Обновить данные, связанные с балансами
        // - Эмиттировать дополнительные события
        // ... 
    }
}