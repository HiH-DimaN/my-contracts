/// Contract with exponentiation function.
/// Write a contract that contains a function for exponentiating a number.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Контракт для вычисления степени числа
/// @author HiH_DimaN
/// @notice Этот контракт предоставляет функцию для вычисления степени числа
/// @dev Все вызовы функций в настоящее время реализованы без побочных эффектов
contract PowerCalculator {
    /// @notice Вычисляет степень числа
    /// @dev Эта функция использует простой итеративный подход для вычисления степени
    /// @param base Основание степени
    /// @param exponent Показатель степени (должен быть неотрицательным)
    /// @return result Результат возведения base в степень exponent
    /// @custom:caution Эта функция может потреблять много газа для больших показателей степени
    function calculatePower(uint256 base, uint256 exponent) public pure returns(uint256 result) {
        require(exponent >=0, "The exponent must be non-negative");

        if (exponent == 0) {
            return 1;
        }

        result = 1;
        for (uint256 i = 0; i <= exponent; i++) {
            result *= base;
        }

        return result;


    }
}
