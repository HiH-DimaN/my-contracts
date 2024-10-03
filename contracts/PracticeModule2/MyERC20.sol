/* Лекция 9 Задание 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

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












}

