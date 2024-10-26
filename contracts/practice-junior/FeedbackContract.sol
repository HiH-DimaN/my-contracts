// Task 30
// Feedback Contract.
// Create a contract that will generate a feedback event when a function is executed.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract to generate a feedback event
contract FeedbackContract {

    // Define an event that will contain the caller address, message, and execution status
    event FeedbackGenerated(address user, string message, bool success);

     // Example of a function that triggers an event during its execution
    function perfomAction(string memory _input) public returns (bool) {
        bool success = false;

        // Logic of action execution
        if (bytes(_input).length > 0) {
            success = true;
        }

        // Generating a feedback event
        emit FeedbackGenerated(msg.sender, "Action has been performed", success);

        return success;
    }
}