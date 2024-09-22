// Task 1
// Simple number storage contract.
// Write a contract that will store a single number and allow it to be updated.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// A contract to keep the number
contract SimpleStorage {
    // Variable for storing a number
    uint256 public storedData;

    // Function to update the number
    function set(uint256 x) public {
        storedData = x;
    }

    // Function to get a number
    function get() public view returns (uint256) {
        return storedData;
    }
}
