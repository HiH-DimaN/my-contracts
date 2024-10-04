/* Лекция 9 Задание 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Импортируем интерфейс IERC20 из OpenZeppelin
import "@openzeppelin/contracts/access/Ownable.sol"; // Импортируем контракт Ownable из OpenZeppelin
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol"; // Импортируем SafeERC20

/*
 * @title MyERC20
 * @dev Базовая реализация стандарта ERC20.
 */
abstract contract MyERC20 is IERC20, Ownable {
    using SafeERC20 for IERC20; // Подключаем SafeERC20 для IERC20

    string private _name; // Имя токена
    string private _symbol; // Символ токена
    uint8 private _decimals; // Количество десятичных знаков
    uint256 private _totalSupply; // Общее количество токенов

    mapping(address => uint256) private _balances; // Балансы адресов
    mapping(address => mapping(address => uint256)) private _allowances; // Разрешения на перевод токенов

    mapping(address => bool) public isBlacklisted; // Маппинг для хранения черного списка адресов

    // Событие, которое генерируется после каждого перевода токенов
    event TokenTransferred(address indexed from, address indexed to, uint256 amount);

    /*
     * @dev Конструктор.
     * @param name_ Название токена.
     * @param symbol_ Символ токена.
     * @param decimals_ Количество десятичных знаков.
     */
    constructor(string memory name_, string memory symbol_, uint8 decimals_) Ownable(msg.sender) { // Вызываем конструктор Ownable с адресом владельца
        _name = name_; // Устанавливаем имя токена
        _symbol = symbol_; // Устанавливаем символ токена
        _decimals = decimals_; // Устанавливаем количество десятичных знаков
    }

    /*
     * @dev Возвращает имя токена.
     * @return Название токена.
     */
    function name() public view virtual  returns (string memory) {
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
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender(); // Определяем адрес отправителя
        _transfer(owner, to, amount); // Вызываем внутреннюю функцию _transfer
        return true; // Возвращаем true, так как safeTransfer выбрасывает ошибку при неудаче
    }

    /*
     * @dev Возвращает разрешенное количество токенов.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешен перевод.
     * @return Количество токенов, разрешенных к трате.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender]; // Возвращаем разрешенное количество токенов
    }

    /*
     * @dev Устанавливает разрешение `spender` тратить токены.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на которые выдано разрешение.
     * @return true, если разрешение успешно установлено.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount); // Вызываем внутреннюю функцию _approve
        return true; // Возвращаем true, так как _approve не может завершиться неудачей
    }

    /*
     * @dev Переводит токены с разрешением от владельца.
     * @param sender Адрес отправителя токенов.
     * @param recipient Адрес получателя.
     * @param amount Количество токенов для перевода.
     * @return true, если перевод успешен.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _spendAllowance(sender, _msgSender(), amount); // Уменьшаем разрешение
        _transfer(sender, recipient, amount); // Вызываем внутреннюю функцию _transfer
        return true; // Возвращаем true, так как safeTransferFrom выбрасывает ошибку при неудаче
    }

    /*
     * @dev Увеличивает разрешение.
     * @param spender  Адрес, которому разрешено тратить токены.
     * @param addedValue  Количество токенов, на которое увеличивается разрешение.
     * @return true, если разрешение успешно увеличено.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, allowance(_msgSender(), spender) + addedValue); // Вызываем внутреннюю функцию _approve
        return true; // Возвращаем true, так как _approve не может завершиться неудачей
    }

    /*
     * @dev Внутренняя функция перевода.
     * @param from Адрес отправителя токенов.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
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
     * @dev Внутренняя функция для выпуска новых токенов.
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
     * @dev Внутренняя функция для сжигания токенов.
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
     * @dev Внутренняя функция для изменения разрешения.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount Количество токенов, на которые выдано разрешение.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address"); // Проверяем, что `owner` не нулевой адрес
        require(spender != address(0), "ERC20: approve to the zero address"); // Проверяем, что `spender` не нулевой адрес

        _allowances[owner][spender] = amount; // Устанавливаем разрешение
        emit Approval(owner, spender, amount); // Генерируем событие Approval
    }

    /*
     * @dev Внутренняя функция для расхода разрешенного количества токенов.
     * @param owner Адрес владельца токенов.
     * @param spender Адрес, которому разрешено тратить токены.
     * @param amount  Количество токенов, на которое уменьшается разрешение.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender); // Определяем текущее разрешение
        require(currentAllowance >= amount, "ERC20: insufficient allowance"); // Проверяем, что текущее разрешение не меньше amount
        unchecked {
            _approve(owner, spender, currentAllowance - amount); // Уменьшаем разрешение
        }
    }

    /* 
     * @dev Hook, который вызывается перед любым переводом токенов.
     * Проверяет, не находится ли отправитель в черном списке.
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {
        require(!isBlacklisted[from], "ERC20: transfer from blacklisted address");
    }

    /* 
     * @dev Hook, который вызывается после любого перевода токенов.
     * Эмитирует событие "TokenTransferred".
     */
    function _afterTokenTransfer(address from,address to, uint256 amount) internal virtual {
        emit TokenTransferred(from, to, amount); // Генерируем событие TokenTransferred
    }
}