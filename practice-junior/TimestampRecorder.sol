// Task 26
// Contract with a timestamp.
// Create a contract that will store the timestamp of the last function call.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimestampRecorder {
    // Variable to store the timestamp of the last function call
    uint public lustUpdated;

    // Function to update the timestamp
    function updateTimestamp() public {
        lustUpdated = block.timestamp; // Save the current timestamp
    }

    // Function to get the current timestamp
    function getLustUpdated() public view returns (uint) {
        return lustUpdated;
    }
}