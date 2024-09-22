// Task 2
// Contract to store the string.
// Write a contract that will store the string and allow it to be updated.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract to store a string
contract StringStorage {
    // Variable to store a string
    string public storedString;

    // Function to update a string
    function set(string memory newString) public {
        storedString = newString;
    }

    // Function for receiving a string
    function get() public view returns (string memory) {
        return storedString;
    }
}

