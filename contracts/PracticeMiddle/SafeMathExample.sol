// Contract using the SafeMath Library.
// Create a contract that uses the SafeMath library for secure mathematical operations.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Импортируем библиотеку SafeMath
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

/* @title Контракт для демонстрации использования SafeMath
 * @author HiH_DimaN
 * @notice Этот контракт использует SafeMath для безопасных математических операций
 */
contract SafeMath {
    // Используем SafeMath для uint256
    using SafeMath for uint256;

    /* @notice Переменная для хранения баланса
     */
    uint256 public balance;

    /* @notice Функция для увеличения баланса
     * @param _amount Количество, на которое нужно увеличить баланс
     */
    function deposit(uint256 _amount) public {
        balance = balance.add(_amount);
    }

     /* @notice Функция для уменьшения баланса
     * @param _amount Количество, на которое нужно уменьшить баланс
     */
    function withdraw(uint256 _amount) public {
        balance = balance.sub(_amount);
    }
    
}