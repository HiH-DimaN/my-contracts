// Task 10
// Contract for division 
// Write a contract that will calculate the quotient of two numbers passed to a function. 
// Make sure that the divisor is not equal to zero.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for calculating the quotient of two numbers
contract Divider {

    // Function for calculating the quotient of two numbers
    function divide(uint256 x, uint256 y) public pure returns (uint256) {
        require(y > 0, "Division by zero");
        return x / y;
    }
}
