// Task 4
// Contract with an array of numbers 
// Write a contract that will store an array of numbers and allow new numbers to be added to the array.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for storing an array of numbers
contract ArrayStorage {
    // Array for storing numbers
    uint256[] public numbers;

    // Function for adding a number to the array
    function addNumber(uint256 number) public {
        numbers.push(number);
    }

    // Function to get a number from the array by index
    function getNumber(uint256 index) public view returns(uint256) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index];
    }
}