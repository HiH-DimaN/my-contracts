// Task 14
// Contract with conditional execution.
// Create a contract that will execute a function only if the passed value satisfies certain conditions.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ConditionChecker {
    // Event for logging the successful execution of the function
    event FunctionExecuted(address indexed sender, uint256 value);

    // A function that executes only if the condition is met
    function executeIfPositive(uint256 value) public {
        // Checking the condition: the value must be greater than zero
        require(value > 0, "Value must be greater than zero");
        // Logging of successful function execution
        emit FunctionExecuted(msg.sender, value);
        // There can be logic here that is executed when the condition is met.
        // For example, updating the contract status or calling other functions.
    }
}
