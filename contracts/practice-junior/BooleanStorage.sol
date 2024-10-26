// Task 3
// Contract with a boolean value 
// Create a contract that will store a boolean value and allow it to be updated.


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for storing a boolean value
contract BooleanStorage {
    // Variable for storing a Boolean value
    bool public storedBoolean;

    // Function for updating a boolean value
    function set(bool x) public {
        storedBoolean = x;
    }

    // Function to get the boolean value
    function get() public view returns(bool) {
        return storedBoolean;
    }
}