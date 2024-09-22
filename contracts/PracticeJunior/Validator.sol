// Task 24
// Contract with conditional checking of parameters/.
// Write a contract that will check that the parameters passed to the function satisfy the given conditions.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Validator {

    // Event to notify about parameter checking
    event ParametersValidated(address indexed _address, uint _number, string _text);

    // Function to check the parameters
    function validateParameters(address _address, uint _number, string memory _text) public {

        // Check that the address is not zero    
        require(_address != address(0), "Address cannot be zero");

        // Check that the number is greater than zero
        require(_number > 0, "Number must be greater than zero");

        // Check that the string is not empty
        require(bytes(_text).length > 0, "Text cannot be emptyText cannot be empty");

        // If all checks are passed, generate the event
        emit ParametersValidated(_address, _number, _text);

    }
}