/* Лекция 9 Задание 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/*
 * @title MyERC20
 * @dev Базовая реализация стандарта ERC20.
 */
abstract contract MyERC20 is IERC20, Ownable {
    using SafeERC20 for IERC20;

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
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    /*
     * @dev Возвращает имя токена.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /*
     * @dev Возвращает символ токена.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /*
     * @dev Возвращает количество десятичных знаков.
     */
    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }

    /*
     * @dev Возвращает общее количество токенов.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /*
     * @dev Возвращает баланс адреса.
     * @param account Адрес, баланс которого нужно вернуть.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /*
     * @dev Переводит токены на адрес.
     * @param to Адрес получателя.
     * @param amount Количество токенов для перевода.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    /*
     * @dev Возвращает разрешенное количество токенов.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /*
     * @dev Устанавливает разрешение `spender` тратить токены.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /*
     * @dev Переводит токены с разрешением от владельца.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _spendAllowance(sender, _msgSender(), amount);
        _transfer(sender, recipient, amount);
        return true;
    }

    /*
     * @dev Увеличивает разрешение.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, allowance(_msgSender(), spender) + addedValue);
        return true;
    }

    /*
     * @dev Внутренняя функция перевода.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);
    }

    /*
     * @dev Внутренняя функция для выпуска новых токенов.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }

    /*
     * @dev Внутренняя функция для сжигания токенов.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);
    }

    /*
     * @dev Внутренняя функция для изменения разрешения.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /*
     * @dev Внутренняя функция для расхода разрешенного количества токенов.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= amount, "ERC20: insufficient allowance");
        unchecked {
            _approve(owner, spender, currentAllowance - amount);
        }
    }
}
