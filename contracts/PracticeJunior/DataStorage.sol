// Task 21
// Contract with an event when data is updated.
// Create a contract that generates an event when data is updated.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataStorage {
    // Variable to store the data
    string public data;

    // Define the event that will be triggered when data is updated
    event DataUpdated(string oldData, string newData);

    // Function to set the data
    function setData(string memory newData) public {
        // Store old data for the event
        string memory oldData = data;
        // Update data
        data = newData;

        // Generate an event when data is updated
        emit DataUpdated(oldData, newData);
    }

    // Function to get current data
    function getData() public view returns (string memory) {
        return data;
    }

}