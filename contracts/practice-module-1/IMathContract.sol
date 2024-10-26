// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title IMathContract
 * @author HiH_DimaN
 * @notice Интерфейс контракта для математических операций.
 */
interface IMathContract {

    /**
     * @dev Функция сложения двух чисел.
     * @param x Первое число.
     * @param y Второе число.
     * @return Сумма двух чисел.
     */
    function add(uint x, uint y) external pure returns (uint);

    /**
     * @dev Функция вычитания двух чисел.
     * @param x Уменьшаемое.
     * @param y Вычитаемое.
     * @return Результат вычитания.
     */
    function subtract(uint x, uint y) external pure returns (uint);

    /**
     * @dev Функция умножения двух чисел.
     * @param x Первый множитель.
     * @param y Второй множитель.
     * @return Результат умножения.
     */
    function multiply(uint x, uint y) external  pure returns (uint);

    /**
     * @dev Функция деления двух чисел.
     * @param x Делимое.
     * @param y Делитель.
     * @return Результат деления.
     */
    function divide(uint x, uint y ) external  pure returns (uint);
    
}