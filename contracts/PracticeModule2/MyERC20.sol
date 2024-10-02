/* Лекция 9 Задание 1: Создать свою реализацию ERC20 с написанием функций из IERC20 --- */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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
 * @dev Конструктор.
 * @param name_ Название токена.
 * @param symbol_ Символ токена.
 * @param decimals_ Количество десятичных знаков.
 */
constructor(string memory name_, string memory symbol_, uint8 decimals_) {
    _name = _name;
    _symbol = symbol_;
    _decimals = decimals_;
}







}

