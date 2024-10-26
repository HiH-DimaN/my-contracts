// Task 15
// Contract with input data validation.
// Write a contract that will check the input data before executing the function.


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for input data validation
contract InputValidation {

    // Function for checking and processing input data
    function validation(uint256 value) public pure returns (string memory) {
        require(value != 0, "Value must be non-zero");
        return "Valid input";
    }
}