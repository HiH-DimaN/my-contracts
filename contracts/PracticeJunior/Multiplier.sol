/** Task 9
Contract for multiplication 
Write a contract that will calculate the product of two numbers passed to a function.
*/

/// @author HiH_DimaN
/// @notice Contract for calculating


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/** @title Contract for calculating the product of two numbers. */
contract Multiplier {
    /** @dev Calculating multiplication of two variables.
      * @param a Variable.
      * @param b Variablee.
      * @return a * b The сalculating multiplication.
      */

    // Function for calculating the product of two numbers
    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }
}