// SPDX-License-Identifier: MIT
// Указываем тип лицензии для контракта.

pragma solidity ^0.8.20;
// Указываем версию компилятора, с которой будет компилироваться контракт.

import "./IERC20Metadata.sol";
// Импортируем интерфейс IERC20Metadata для поддержки расширенной функциональности токена.

/**
 * @title ERC20
 * @dev Реализация стандарта токена ERC20 с базовыми функциями управления токенами.
 */
contract ERC20 is IERC20Metadata {
    // Маппинг для отслеживания балансов пользователей.
    mapping(address => uint) private _balances;

    // Маппинг для отслеживания разрешений (allowances) между владельцами и операторами.
    mapping(address => mapping(address => uint)) private _allowances;

    // Общее количество токенов в обращении.
    uint private _totalSupply;

    // Название токена.
    string private _name;

    // Символ токена.
    string private _symbol;

    /**
     * @dev Конструктор устанавливает имя и символ токена.
     * @param initialName Имя токена.
     * @param symbol_ Символ токена.
     */
    constructor(string memory initialName, string memory symbol_) {
        _name = initialName; // Устанавливаем имя токена.
        _symbol = symbol_; // Устанавливаем символ токена.
    }

    /**
     * @dev Возвращает имя токена.
     * @return Имя токена.
     */
    function name() external view returns (string memory) {
        return _name; // Возвращаем имя токена.
    }

    /**
     * @dev Возвращает символ токена.
     * @return Символ токена.
     */
    function symbol() external view returns (string memory) {
        return _symbol; // Возвращаем символ токена.
    }

    /**
     * @dev Возвращает количество десятичных знаков, используемых для представления токена.
     * @return Число десятичных знаков (по умолчанию 0).
     */
    function decimals() public pure virtual returns (uint8) {
        return 0; // Количество десятичных знаков. Можно изменить на 18 для соответствия стандарту.
    }

    /**
     * @dev Возвращает общее количество токенов в обращении.
     * @return Общее количество токенов.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply; // Возвращаем общее количество токенов.
    }

    /**
     * @dev Возвращает баланс указанного адреса.
     * @param account Адрес владельца токенов.
     * @return Баланс токенов данного адреса.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account]; // Возвращаем баланс указанного аккаунта.
    }

    /**
     * @dev Переводит токены от отправителя к указанному адресу.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return Успешность операции (true).
     */
    function transfer(address to, uint256 amount) public returns (bool) {
        address owner = msg.sender; // Определяем адрес отправителя.
        _transfer(owner, to, amount); // Вызываем внутреннюю функцию перевода.
        return true; // Возвращаем успешность операции.
    }

    /**
     * @dev Возвращает текущее разрешение между владельцем и оператором.
     * @param owner Адрес владельца.
     * @param spender Адрес оператора.
     * @return Количество токенов, которые оператор может использовать.
     */
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender]; // Возвращаем текущее разрешение.
    }

    /**
     * @dev Устанавливает разрешение на использование токенов для указанного оператора.
     * @param spender Адрес оператора.
     * @param amount Количество токенов для разрешения.
     * @return Успешность операции (true).
     */
    function approve(address spender, uint256 amount) external returns (bool) {
        address owner = msg.sender; // Определяем адрес владельца.
        _approve(owner, spender, amount); // Вызываем внутреннюю функцию для установки разрешения.
        return true; // Возвращаем успешность операции.
    }

    /**
     * @dev Переводит токены с одного адреса на другой с использованием разрешения.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return Успешность операции (true).
     */
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        address spender = msg.sender; // Определяем адрес оператора.
        _spendAllowance(from, spender, amount); // Уменьшаем разрешение.
        _transfer(from, to, amount); // Выполняем перевод токенов.
        return true; // Возвращаем успешность операции.
    }

    /**
     * @dev Увеличивает разрешение для указанного оператора.
     * @param spender Адрес оператора.
     * @param addedValue Дополнительное количество токенов для разрешения.
     * @return Успешность операции (true).
     */
    function increaseAllowance(address spender, uint addedValue) public virtual returns (bool) {
        address owner = msg.sender; // Определяем адрес владельца.
        _approve(owner, spender, allowance(owner, spender) + addedValue); // Увеличиваем разрешение.
        return true; // Возвращаем успешность операции.
    }

    /**
     * @dev Уменьшает разрешение для указанного оператора.
     * @param spender Адрес оператора.
     * @param subValue Количество токенов для уменьшения разрешения.
     * @return Успешность операции (true).
     */
    function decreaseAllowance(address spender, uint subValue) public virtual returns (bool) {
        address owner = msg.sender; // Определяем адрес владельца.
        uint currentAllowance = allowance(owner, spender); // Получаем текущее разрешение.
        require(currentAllowance >= subValue, "allowance should be >= subValue"); // Проверка на недостаток разрешения.
        unchecked {
            _approve(owner, spender, currentAllowance - subValue); // Уменьшаем разрешение без проверки на переполнение.
        }
        return true; // Возвращаем успешность операции.
    }

    /**
     * @dev Внутренняя функция для выполнения перевода токенов.
     * @param from Адрес отправителя.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     */
    function _transfer(address from, address to, uint amount) internal virtual {
        require(from != address(0), "From cannot be zero addr!"); // Проверяем, что адрес отправителя не нулевой.
        require(to != address(0), "To cannot be zero addr!"); // Проверяем, что адрес получателя не нулевой.
        _beforeTokenTransfer(from, to, amount); // Хук, вызываемый перед переводом токенов.
        uint fromBalance = _balances[from]; // Получаем баланс отправителя.
        require(fromBalance >= amount, "insufficient funds!"); // Проверяем, что на балансе отправителя достаточно токенов.
        unchecked {
            _balances[from] = fromBalance - amount; // Уменьшаем баланс отправителя.
            _balances[to] += amount; // Увеличиваем баланс получателя.
        }
        emit Transfer(from, to, amount); // Генерируем событие Transfer.
        _afterTokenTransfer(from, to, amount); // Хук, вызываемый после перевода токенов.
    }

    /**
     * @dev Внутренняя функция для создания новых токенов.
     * @param account Адрес, на который будут зачислены новые токены.
     * @param amount Количество токенов для создания.
     */
    function _mint(address account, uint amount) internal virtual {
        require(account != address(0), "Account cannot be zero!"); // Проверяем, что адрес не нулевой.
        _beforeTokenTransfer(address(0), account, amount); // Хук перед созданием токенов.
        _totalSupply += amount; // Увеличиваем общее количество токенов.
        unchecked {
            _balances[account] += amount; // Увеличиваем баланс указанного аккаунта.
        }
        emit Transfer(address(0), account, amount); // Генерируем событие Transfer для создания токенов.
        _afterTokenTransfer(address(0), account, amount); // Хук после создания токенов.
    }

    /**
 * @dev Внутренняя функция для уничтожения (сжигания) токенов указанного аккаунта.
 * Уменьшает общее количество токенов в обращении.
 * @param account Адрес аккаунта, с которого будут списаны токены.
 * @param amount Количество токенов для уничтожения.
 */
function _burn(address account, uint amount) internal virtual {
    require(account != address(0), "Account cannot be zero!"); // Проверка, что адрес аккаунта не нулевой.

    _beforeTokenTransfer(account, address(0), amount); // Хук, вызываемый перед уничтожением токенов.

    uint accountBalance = _balances[account]; // Получаем текущий баланс аккаунта.
    require(accountBalance >= amount, "insufficient funds"); // Проверка, что на балансе аккаунта достаточно токенов для уничтожения.
    unchecked {
        _balances[account] = accountBalance - amount; // Уменьшаем баланс аккаунта на указанное количество токенов.
        _totalSupply -= amount; // Уменьшаем общее количество токенов.
    }

    emit Transfer(account, address(0), amount); // Генерация события Transfer с адресом назначения 0x0 (обычно обозначает уничтожение токенов).

    _afterTokenTransfer(account, address(0), amount); // Хук, вызываемый после уничтожения токенов.
}

/**
 * @dev Внутренняя функция для установки разрешения на использование токенов владельца указанным оператором.
 * @param owner Адрес владельца токенов.
 * @param spender Адрес оператора, который может использовать токены.
 * @param amount Количество токенов для разрешения.
 */
function _approve(address owner, address spender, uint amount) internal virtual {
    require(owner != address(0), "Owner cannot be zero!"); // Проверка, что адрес владельца не нулевой.
    require(spender != address(0), "Spender cannot be zero!"); // Проверка, что адрес оператора не нулевой.

    _allowances[owner][spender] = amount; // Устанавливаем разрешение для указанного оператора.

    emit Approval(owner, spender, amount); // Генерация события Approval.
}

/**
 * @dev Внутренняя функция для уменьшения разрешения оператора на использование токенов владельца.
 * @param owner Адрес владельца токенов.
 * @param spender Адрес оператора, который использует токены.
 * @param amount Количество токенов для списания с разрешения.
 */
function _spendAllowance(address owner, address spender, uint amount) internal virtual {
    uint currentAllowance = allowance(owner, spender); // Получаем текущее разрешение.

    if (currentAllowance != type(uint256).max) { // Проверка, что разрешение не установлено на максимальное значение.
        require(currentAllowance >= amount, "insufficient allowance"); // Проверка, что разрешение достаточно для списания указанного количества токенов.
        unchecked {
            _approve(owner, spender, currentAllowance - amount); // Уменьшаем разрешение на указанное количество.
        }
    }
}

/**
 * @dev Внутренняя функция-хук, вызываемая перед любым переводом токенов.
 * Может быть переопределена для применения дополнительных логик.
 * @param from Адрес отправителя.
 * @param to Адрес получателя.
 * @param amount Количество токенов для перевода.
 */
function _beforeTokenTransfer(address from, address to, uint amount) internal virtual {}

/**
 * @dev Внутренняя функция-хук, вызываемая после любого перевода токенов.
 * Может быть переопределена для применения дополнительных логик.
 * @param from Адрес отправителя.
 * @param to Адрес получателя.
 * @param amount Количество токенов для перевода.
 */
function _afterTokenTransfer(address from, address to, uint amount) internal virtual {}

}








