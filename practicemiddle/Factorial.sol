// Contract with the factorial function.
//  Create a contract that contains a function for calculating the factorial of a number.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/* @title Контракт для вычисления факториала числа
 * @author HiH_DimaN
 * @notice Этот контракт содержит функцию для вычисления факториала
 */
contract Facrtorial {
    /* @notice Функция для вычисления факториала числа
     * @dev Использует цикл для итеративного вычисления факториала
     * @param n Число, для которого нужно вычислить факториал
     * @return result Факториал числа n
     */
    function factorial(uint256 n) public pure returns(uint256 result) {
        if (n == 0) {
            return 1;
        }
        result = 1;

        for (uint256 i = 1; i < n; i++) {
            result *= i;
        }
    }
}
