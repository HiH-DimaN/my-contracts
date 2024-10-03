/* Задание 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Импортируем интерфейс IERC20 из OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol"; // Импортируем контракт Ownable из OpenZeppelin

/*
 * @title MyERC20
 * @dev Базовая реализация стандарта ERC20.
 */
abstract contract MyERC20 is IERC20, Ownable {
    string private _name; // Имя токена
    string private _symbol; // Символ токена
    uint8 private _decimals; // Количество десятичных знаков
    uint256 private _totalSupply; // Общее количество токенов

    mapping(address => uint256) private _balances; // Балансы адресов
    mapping(address => mapping(address => uint256)) private _allowances; // Разрешения на перевод токенов

    /*
     * @dev Конструктор.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество десятичных знаков.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_; // Устанавливаем имя токена
        _symbol = symbol_; // Устанавливаем символ токена
        _decimals = decimals_; // Устанавливаем количество десятичных знаков
    }

    /*
     * @dev Возвращает имя токена.
     * @return Название токена.
     */
    function name() public view virtual returns (string memory) {
        return _name; // Возвращаем имя токена
    }

    /*
     * @dev Возвращает символ токена.
     * @return Символ токена.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol; // Возвращаем символ токена
    }

    /*
     * @dev Возвращает количество десятичных знаков.
     * @return Количество десятичных знаков.
     */
    function decimals() public view virtual returns (uint8) {
        return _decimals; // Возвращаем количество десятичных знаков
    }

    /*
     * @dev Возвращает общее количество токенов.
     * @return Общее количество токенов.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply; // Возвращаем общее количество токенов
    }

    /*
     * @dev Возвращает баланс адреса.
     * @param account Адрес, баланс которого нужно вернуть.
     * @return Баланс указанного адреса.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account]; // Возвращаем баланс адреса
    }

    /*
     * @dev Переводит токены на адрес.
     * 
     * Требования:
     * - Баланс отправителя должен быть не меньше `amount`.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен, false в противном случае.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender(); // Определяем адрес отправителя
        _transfer(owner, to, amount); // Вызываем внутреннюю функцию _transfer
        return true;
    }

    /*
     * @dev Возвращает остаток разрешенного количества токенов, которые
     * `spender` может потратить от имени `owner`.
     *
     * This value changes when {approve} or {transferFrom} are called.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешен перевод.
     * @return Количество токенов, разрешенных к трате.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender]; // Возвращаем остаток разрешенного количества токенов
    }

    /*
     * @dev Устанавливает разрешение `spender` тратить токены от имени `owner` до `amount`.
     *
     * Эмиттирует событие {Approval}.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на которые выдано разрешение.
     * @return true, если разрешение успешно установлено, false в противном случае.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender(); // Определяем адрес владельца
        _approve(owner, spender, amount); // Вызываем внутреннюю функцию _approve
        return true;
    }

    /*
     * @dev Увеличивает разрешение `spender` тратить токены от имени `owner` на `addedValue`.
     *
     * Эмиттирует событие {Approval}.
     * @param spender  Адрес, которому разрешено тратить токены.
     * @param addedValue  Количество токенов, на которое увеличивается разрешение.
     * @return true, если разрешение успешно увеличено, false в противном случае.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender(); // Определяем адрес владельца
        _approve(owner, spender, allowance(owner, spender) + addedValue); // Вызываем внутреннюю функцию _approve
        return true;
    }

    /*
     * @dev Переводит `amount` токенов от `sender` к `recipient`, используя разрешение.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - `sender` должен иметь баланс не меньше `amount`.
     * - `spender` должен иметь разрешение не меньше `amount` от `sender`.
     * @param sender Адрес отправителя токенов.
     * @param recipient Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен, false в противном случае.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender(); // Определяем адрес отправителя
        _spendAllowance(sender, spender, amount); // Уменьшаем разрешение
        _transfer(sender, recipient, amount); // Вызываем внутреннюю функцию _transfer
        return true;
    }

    /*
     * @dev Переводит токены от `from` к `to`.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - `from` должен иметь баланс не меньше `amount`.
     * - `to` не должен быть нулевым адресом.
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address"); // Проверяем, что `from` не нулевой адрес
        require(to != address(0), "ERC20: transfer to the zero address"); // Проверяем, что `to` не нулевой адрес

        _beforeTokenTransfer(from, to, amount); // Вызываем хук _beforeTokenTransfer

        uint256 fromBalance = _balances[from]; // Определяем баланс отправителя
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance"); // Проверяем, что баланс отправителя не меньше amount
        unchecked {
            _balances[from] = fromBalance - amount; // Уменьшаем баланс отправителя
        }
        _balances[to] += amount; // Увеличиваем баланс получателя

        emit Transfer(from, to, amount); // Генерируем событие Transfer

        _afterTokenTransfer(from, to, amount); // Вызываем хук _afterTokenTransfer
    }

    /* 
     * @dev Создает `amount` токенов и присваивает их `account`, увеличивая
     * общее предложение.
     *
     * Эмиттирует событие {Transfer} с `from` установленным в нулевой адрес.
     *
     * Требования:
     *
     * - `account` не должен быть нулевым адресом.
     * @param account Адрес получателя токенов.
     * @param amount  Количество создаваемых токенов.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address"); // Проверяем, что `account` не нулевой адрес

        _beforeTokenTransfer(address(0), account, amount); // Вызываем хук _beforeTokenTransfer

        _totalSupply += amount; // Увеличиваем общее количество токенов
        _balances[account] += amount; // Увеличиваем баланс получателя
        emit Transfer(address(0), account, amount); // Генерируем событие Transfer

        _afterTokenTransfer(address(0), account, amount); // Вызываем хук _afterTokenTransfer
    }

    /*
     * @dev Сжигает `amount` токенов от `account`, уменьшая
     * общее предложение.
     *
     * Эмиттирует событие {Transfer} с `to` установленным в нулевой адрес.
     *
     * Требования:
     *
     * - `account` не должен быть нулевым адресом.
     * - `account` должен иметь баланс не меньше `amount`.
     * @param account Адрес, с которого будут сожжены токены
     * @param amount  Количество сжигаемых токенов.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address"); // Проверяем, что `account` не нулевой адрес

        _beforeTokenTransfer(account, address(0), amount); // Вызываем хук _beforeTokenTransfer

        uint256 accountBalance = _balances[account]; // Определяем баланс account
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance"); // Проверяем, что баланс account не меньше amount
        unchecked {
            _balances[account] = accountBalance - amount; // Уменьшаем баланс account
        }
        _totalSupply -= amount; // Уменьшаем общее количество токенов

        emit Transfer(account, address(0), amount); // Генерируем событие Transfer

        _afterTokenTransfer(account, address(0), amount); // Вызываем хук _afterTokenTransfer
    }

    /*
     * @dev Устанавливает `amount` как разрешение `spender` тратить токены от имени `owner`.
     *
     * Эмиттирует событие {Approval}.
     *
     * Требования:
     *
     * - `owner` не должен быть нулевым адресом.
     * - `spender` не должен быть нулевым адресом.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на которые выдано разрешение.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address"); // Проверяем, что `owner` не нулевой адрес
        require(spender != address(0), "ERC20: approve to the zero address"); // Проверяем, что `spender` не нулевой адрес

        _allowances[owner][spender] = amount; // Устанавливаем разрешение
        emit Approval(owner, spender, amount); // Генерируем событие Approval
    }

    /*
     * @dev Уменьшает разрешение `spender` тратить токены от имени `owner` на `subtractedValue`.
     *
     * Требования:
     *
     * - `spender` должен иметь разрешение не меньше `subtractedValue` от `owner`.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param subtractedValue  Количество токенов, на которое уменьшается разрешение.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 subtractedValue
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender); // Определяем текущее разрешение
        require(currentAllowance >= subtractedValue, "ERC20: insufficient allowance"); // Проверяем, что текущее разрешение не меньше subtractedValue
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue); // Уменьшаем разрешение
        }
    }

    /* 
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
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя токенов.
     * @param amount Количество переводимых токенов.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {} // Пустая функция

    /*
     * @dev Hook, который вызывается после любого перевода токенов. Это включает в себя
     * минт и сжигание.
     *
     * Calling conditions:
     *
     * - Когда `from` и `to` не являются нулевыми адресами, `amount` токенов было переведено от `from` к `to`.
     * - Когда `from` - нулевой адрес, `amount` токенов было создано для `to`.
     * - Когда `to` - нулевой адрес, `amount` токенов было сожжено от `from`.
     * - `from` и `to` - никогда не будут одновременно нулевыми адресами.
     *
     * Чтобы узнать больше о том, как перехватить события передачи токенов, см. {IERC20-afterTokenTransfer}.
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя токенов.
     * @param amount Количество переводимых токенов.
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {} // Пустая функция
}
