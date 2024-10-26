// Task 18
// Contract with iteration over an array.
// Write a contract that will summarize all elements in an array.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// A contract to summarize all elements of an array
contract ArraySum {

    // Array for storing numbers
    uint256[] public numbers;

    // Function for adding a number to the array
    function addNumber(uint256 number) public {
        numbers.push(number);
    }

    // Function to summarize all numbers in the array
    function getSum() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }

        return sum;
    }
    
}