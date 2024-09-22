// Task 16
// Contract with deletion of array elements.
// Write a contract that will allow you to remove elements from an array by index.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for deleting array elements by index
contract ArrayDeletion {
    // Array for storing numbers
    uint256[] public numbers;

    // Function for adding a number to the array
    function addNumber(uint256 index) public {
        numbers.push(index);
    }

    // Function to remove a number from the array by index
    function removeNumber(uint256 index) public {
        require(index < numbers.length, "Index out of bounds");
        for (uint256 i = index; i < numbers.length - 1; i++) {
            numbers[i] = numbers[i+1];
        }
        numbers.pop();
    }

    // Function to get a number from the array by index
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index];
    }
}