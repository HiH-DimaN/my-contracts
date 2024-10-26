// Task 25
// A contract that returns multiple values.
// Write a contract that will return multiple values from a function.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiReturnExample {

    // Function that returns multiple values
    function getValues() public pure  returns (uint, bool, string memory) {
        uint number = 42;
        bool isTrue = true;
        string memory message = "Hello, Solidity!";

        return (number, isTrue, message);
    }
}