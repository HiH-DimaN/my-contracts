// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импортируем интерфейс ERC20 из OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyERC20
 * @dev Реализация стандарта ERC20 для создания токенов.
 * Этот контракт является абстрактным и не предназначен для самостоятельного использования.
 * Он содержит базовую логику для ERC20 токена, 
 * но требует от наследника реализации конструктора и 
 * дополнительных функций, таких как mint и burn.
 */
abstract contract MyERC20_0 is IERC20, Ownable {
    // Название токена
    string private _name;
    // Символ токена
    string private _symbol;
    // Количество знаков после запятой
    uint8 private _decimals;
    // Общее количество токенов
    uint256 private _totalSupply;
    // Балансы адресов
    // address => balance
    mapping(address => uint256) private _balances;
    // Список разрешений на перевод токенов
    // owner => (spender => amount)
    mapping(address => mapping(address => uint256)) private _allowances;

    // Флаг, указывающий, приостановлен ли контракт
    bool private _paused;
    // Флаг, указывающий, разрешено ли сжигание токенов
    bool private _burningEnabled;

    /**
     * @dev Событие, возникающее при выдаче разрешения на перевод токенов.
     * @param owner Адрес владельца токенов, который выдал разрешение.
     * @param spender Адрес, которому выдано разрешение на перевод токенов.
     * @param value Количество токенов, на перевод которых выдано разрешение.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Событие, возникающее при переводе токенов.
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя токенов.
     * @param value Количество переданных токенов.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

     /**
     * @dev Модификатор, разрешающий выполнение функции только если контракт не приостановлен.
     */
    modifier whenNotPaused() {
        require(!_paused, "ERC20 paused");
        _;
    } 

     /**
     * @dev Модификатор, разрешающий выполнение функции только если сжигание токенов разрешено.
     */
    modifier whenBurningEnabled() {
        require(_burningEnabled, "ERC20: burning disable");
        _;
    }

     /**
     * @dev Конструктор для инициализации токена.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество знаков после запятой.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        // Изначально контракт не приостановлен, а сжигание токенов разрешено
        _paused = false;
        _burningEnabled = true;
    }

     /**
     * @dev Возвращает имя токена.
     * @return Название токена.
     */
    function name() public view virtual override returns(string memory) {
        return _name;
    }

      /**
     * @dev Возвращает символ токена.
     * @return Символ токена.
     */
    function symbol() public view virtual override returns(string memory) {
        return _symbol;
    }

    /**
     * @dev Возвращает количество знаков после запятой.
     * @return Количество знаков после запятой.
     */
    function decimals() public view virtual override returns(uint8) {
        return _decimals;
    }

    /**
     * @dev Возвращает общее количество токенов.
     * @return Общее количество токенов.
     */
    function totalSupply() public view virtual override returns(uint256) {
        return _totalSupply;
    }

    /**
     * @dev Возвращает баланс указанного адреса.
     * @param account Адрес, баланс которого нужно вернуть.
     * @return Баланс указанного адреса.
     */
    function balanceOf(address account) public view virtual override returns(uint256) {
        return _balances[account];
    }

    /**
     * @dev Переводит токены на указанный адрес.
     * @param recipient Адрес получателя токенов.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен, false в противном случае.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - Баланс отправителя (msg.sender) должен быть не меньше amount.
     * - Контракт не должен быть приостановлен.
     */
    function transfer(address recipient, uint256 amount) public virtual override whenNotPaused returns (bool) {
        // Проверяем, достаточно ли токенов у отправителя для перевода
        require(_balances[msg.sender] >= amount, "ERC20: transfer amount exceeds balance");
        
        _transfer(msg.sender, recipient, amount);

        // Эмиттируем событие Transfer после успешного перевода
        emit Transfer(msg.sender, recipient, amount);

        return true;
    }

    /**
     * @dev Возвращает количество токенов, 
     * которые отправитель (owner) разрешил тратить указанному spender.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @return Количество токенов, разрешенных к трате.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

     /**
     * @dev Устанавливает разрешение на перевод токенов от имени отправителя (msg.sender).
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на перевод которых выдано разрешение.
     * @return true, если разрешение успешно установлено, false в противном случае.
     *
     * Эмиттирует событие {Approval}.
     * 
     * Требования:
     * - Контракт не должен быть приостановлен.
     */
    function approve(address spender, uint256 amount) public virtual override whenNotPaused returns (bool) {
        _approve(msg.sender, spender, amount);

        // Эмиттируем событие Approval после успешного eстанавлиения разрешения на перевод токенов от имени отправителя (msg.sender)
        emit Approval(msg.sender, spender, amount);

        return true;

    }

    /**
     * @dev Переводит токены от имени отправителя (sender) на адрес получателя (recipient), 
     * используя ранее выданное разрешение.
     *
     * @param sender Адрес отправителя токенов.
     * @param recipient Адрес получателя токенов.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен, false в противном случае.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - Баланс отправителя (sender) должен быть не меньше amount.
     * - Разрешение, выданное отправителем (sender) для адреса msg.sender, 
     * должно быть не меньше amount.
     * - Контракт не должен быть приостановлен.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override whenNotPaused returns (bool) {
        // Вызываем внутреннюю функцию _transfer для перевода токенов
        _transfer(sender, recipient, amount);

        // Проверяем, достаточно ли разрешений у msg.sender 
        // на перевод токенов от имени sender
        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");

        // Уменьшаем разрешение на amount, так как токены уже переведены
        unchecked {
            _approve(sender, msg.sender, currentAllowance - amount);
        }

        // Эмиттируем событие Transfer после успешного перевода
        emit Transfer(sender, recipient, amount);

        return true;

    }

    /**
     * @dev Внутренняя функция для перевода токенов от адреса sender на адрес recipient.
     *
     * @param sender Адрес отправителя токенов.
     * @param recipient Адрес получателя токенов.
     * @param amount Количество токенов для перевода.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - sender не должен быть нулевым адресом.
     * - recipient не должен быть нулевым адресом.
     * - Баланс sender должен быть не меньше amount.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {

        // Проверяем, что sender и recipient не являются нулевыми адресами
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        // Проверяем, достаточно ли токенов у sender для перевода
        uint256 senderBalace = _balances[sender];
        require(senderBalace >= amount, "ERC20: transfer amount exceeds balance");

        // Изменяем балансы sender и recipient
        unchecked {
            _balances[sender] = senderBalace - amount;

        }

        _balances[recipient] += amount;

        // Эмиттируем событие Transfer
        emit Transfer(sender, recipient, amount);
    }

    /**
     * @dev Внутренняя функция для создания новых токенов и добавления их на баланс account.
     *
     * @param account Адрес, на который будут зачислены новые токены.
     * @param amount Количество создаваемых токенов.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - account не должен быть нулевым адресом.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        // Увеличиваем общее количество токенов и баланс account
        _totalSupply += amount;
        _balances[account] += amount;

        // Эмиттируем событие Transfer
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Внутренняя функция для сжигания amount токенов с баланса account.
     *
     * @param account Адрес, с которого будут сожены токены.
     * @param amount Количество сжигаемых токенов.
     *
     * Эмиттирует событие {Transfer}.
     *
     * Требования:
     * - account не должен быть нулевым адресом.
     * - Баланс account должен быть не меньше amount.
     * - Сжигание токенов должно быть разрешено.
     */
    function _burn(address account, uint256 amount) internal virtual override whenBurningEnabled {
        require(account != address(0, "ERC20: burn from the zero address");

        // Проверяем, достаточно ли токенов у account для сжигания
        uint256 accountBalance = _balance[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");

        // Уменьшаем баланс account и общее количество токенов
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        // Эмиттируем событие Transfer
        emit Transfer(account, address(0), amount);

    } 

    /**
     * @dev Внутренняя функция для установки разрешения на перевод токенов.
     * Позволяет spender тратить токены от имени owner до amount.
     *
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на перевод которых выдано разрешение.
     *
     * Эмиттирует событие {Approval}.
     *
     * Требования:
     * - owner не должен быть нулевым адресом.
     * - spender не должен быть нулевым адресом.
     */
    function _approve(address owner, address spender, uint256 amount)internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        // Устанавливаем разрешение
        _allowances[owner][spender] = amount;

        // Эмиттируем событие Approval
        emit Approval(owner, spender, amount);
    
    }

    /**
     * @dev Приостанавливает выполнение большинства функций контракта.
     * Доступно только владельцу контракта.
     */
    function pause() public onlyOwner {
        _paused = true;
    }

    /**
     * @dev Возобновляет выполнение функций контракта после паузы.
     * Доступно только владельцу контракта.
     */
    function unpause() public onlyOwner {
        _paused = false;
    }

    /**
     * @dev Запрещает сжигание токенов.
     * Доступно только владельцу контракта.
     */
    function disableBurning() public onlyOwner {
        _burningEnabled = false;
    }

    /**
     * @dev Разрешает сжигание токенов.
     * Доступно только владельцу контракта.
     */
    function enableBurning() public onlyOwner {
        _burningEnabled = true;
    }

}  
