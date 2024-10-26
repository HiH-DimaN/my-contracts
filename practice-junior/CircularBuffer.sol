// Task 20
// Contract with a cyclic array.
// Write a contract that will use a cyclic array to store values.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CircularBuffer {
    // Array for storing values
    uint256[] private buffer;
    // Maximum buffer size
    uint256 private size;
    // Current index to add a new value
    uint256 private index;

    // Constructor that initializes the buffer size and the array
    constructor(uint256 _size) {
        require(_size > 0, "Size must be > 0");
        buffer = new uint256[](_size);
        size = _size;
        index = 0;
    }

    // Function for adding a new value to the buffer
    function add(uint256 value) public {
        buffer[index] = value;
        // Update the index using the modular operator to cycle through the array
        index = (index + 1) % size;
    }

    // Function to get the value by the index
    function get(uint256 idx) public view returns (uint256) {
        require(idx < size, "Index out of bounds");
        // Use the modular operator to correctly access values in the cyclic array
        return buffer[(index + idx) % size];
    }

    // Function to get the current buffer size
    function getSize() public view returns (uint256) {
        return size;
    }
}