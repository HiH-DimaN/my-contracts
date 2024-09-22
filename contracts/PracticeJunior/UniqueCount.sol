// Task 29
// Contract with counting of unique values/
// Write a contract to count the number of unique values in an array.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract to count the number of unique values in an array
contract UniqueCount {
    // Array for storing unique values
    uint[] public uniqueValues;

    // Function for adding a unique value to the array
    function addUniqueValue(uint value) public {
        for (uint i = 0; i < uniqueValues.length; i++) {
            require(uniqueValues[i] != value, "");
        }
        uniqueValues.push(value);
    }

    // Function to get the number of unique values in the array
    function getUniqueCount() public view   returns (uint) {
        return uniqueValues.length;
    }

}