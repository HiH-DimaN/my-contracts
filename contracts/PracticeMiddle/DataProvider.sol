// Contract to interact with another contract.
// Create a contract that interacts with another contract to retrieve data.

// Contract that stores data (DataProvider.sol)

// SPDX-License--Identifier: MIT
pragma solidity ^0.8.0;

contract DataProvider {
    // Stores data
    uint256 private data;

    // Constructor for setting the initial data value
    constructor(uint256 _initialData) {
        data = _initialData;
    }

    // Function for setting a new data value
    function setData(uint256 _newData) external {
        data = _newData;
    }

    // Function to get the current data value
    function getData() external view returns(uint256) {
        return data;
    }
}