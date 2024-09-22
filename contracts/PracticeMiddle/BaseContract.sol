// Contract for inheritance.
// Write a base contract and a contract that inherits it and extends the functionality.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base contract
contract BaseContract {
    // Value
    uint public value;

    // Constructor, initializing the value
    constructor(uint _initialValue) {
        value = _initialValue;
    }

    // Function for setting the value
    function setValue(uint _newValue) public virtual {
        value = _newValue;
    }

    // Function to get the value
    function getValue() public view returns(uint) {
        return value;
    }
}