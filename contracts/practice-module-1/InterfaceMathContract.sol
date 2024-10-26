// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IMathContract.sol";

/**
 * @title InterfacrMathContract
 * @author HiH_DimaN
 * @notice Контракт, который использует интерфейс IMathContract для математических операций.
 */
contract InterfacrMathContract {
    /**
     * @dev Ссылка на контракт IMathContract.
     */
    IMathContract mathContract; // Ссылка на контракт IMathContract

    /**
     * @dev Конструктор контракта.
     * @param _mathContractAddress Адрес контракта IMathContract.
     */
    constructor(address _mathContractAddress) {
        mathContract = IMathContract(_mathContractAddress); // Инициализация ссылки на контракт IMathContract
    }

    /**
     * @dev Функция сложения двух чисел.
     * @param a Первое число.
     * @param b Второе число.
     * @return Результат сложения.
     */
    function addNumber(uint a, uint b) public view returns (uint) {
        return mathContract.add(a, b); // Вызов функции add() из контракта IMathContract
    }

    /**
     * @dev Функция вычитания двух чисел.
     * @param a Уменьшаемое.
     * @param b Вычитаемое.
     * @return Результат вычитания.
     */
    function subtractNumber(uint a, uint b) public view returns (uint) {
        return mathContract.subtract(a, b); // Вызов функции subtract() из контракта IMathContract
    }

    /**
     * @dev Функция умножения двух чисел.
     * @param a Первый множитель.
     * @param b Второй множитель.
     * @return Результат умножения.
     */
    function multiplyNumber(uint a, uint b) public view returns (uint) {
        return mathContract.multiply(a, b); // Вызов функции multiply() из контракта IMathContract
    }

    /**
     * @dev Функция деления двух чисел.
     * @param a Делимое.
     * @param b Делитель.
     * @return Результат деления.
     */
    function divideNumber(uint a, uint b) public view returns (uint){
        return  mathContract.divide(a, b); // Вызов функции divide() из контракта IMathContract
    } 
}