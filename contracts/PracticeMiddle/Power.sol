// Contract with exponentiation function.
// Write a contract that contains a function for exponentiating a number.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* @title Контракт для возведения числа в степень
 * @author HiH_DimaN
 * @notice Этот контракт содержит функцию для безопасного возведения числа в степень
 */
contract Power {

    /* @notice Функция для возведения числа в степень
     * @dev Использует цикл для безопасного вычисления степени без переполнения
     * @param base Основание степени
     * @param exponent Показатель степени
     * @return result Результат возведения в степень
     */
    function pow(uint256 base, uint256 exponent) public pure returns(uint256 result) {
        require(exponent >=0, "The exponent must be non-negative");

        if (exponent == 0) {
            return 1;
        }

        result = 1;
        for (uint256 i = 0; i < exponent; i++) {
            result *= base;
        }

        return result;


    }
}
