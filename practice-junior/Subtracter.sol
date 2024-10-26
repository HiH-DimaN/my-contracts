// Task 8
// Contract for calculating the difference 
// Create a contract that will calculate the difference of two numbers passed to the function.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for calculating the difference of two numbers
contract Subtracter {

    // Function for calculating the difference of two numbers
    function subtract(uint256 x, uint256 y) public pure returns(uint256) {
        return x - y;
    }
}