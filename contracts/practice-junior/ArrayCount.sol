// Task 17
// Contract with counting the elements of an array.
// Create a contract that returns the number of elements in an array.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A contract for counting array elements
contract ArrayCount {
    
    // Array for storing numbers
    uint256[] public numbers;

    // Function to add a number to the array
    function addNumber(uint256 number) public {
        numbers.push(number);
    }

    // Function to get the number of elements in the array
    function getCount() public view returns (uint256) {
        return numbers.length;
    }
    
}