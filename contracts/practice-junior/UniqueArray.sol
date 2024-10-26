// Task 28
// Contract with unique values in an array.
// Create a contract to add only unique values to an array.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Contract to add only unique values to the array
contract UniqueArray {
    // Array to store unique values
    uint[] public uniqueValues;

    // Event that will be emitted when a new value is added
    event AddedValue(uint _value);

    // Function for adding a unique value to the array
    function addUniqueValues(uint _value) public {
        for (uint i = 0; i <= uniqueValues.length; i++) {
            require(uniqueValues[i] != _value, "Value already exists");
        }
        uniqueValues.push(_value);

        // Emit the event of adding a value
        emit AddedValue(_value);
    }

    // Function to get a value from the array by index
    function getValue(uint index) public view returns (uint) {
        require(index < uniqueValues.length, "Index out of bounds");
        return uniqueValues[index];
    }

    // Function to get all unique values
    function getValues() public view returns (uint[] memory) {
        return uniqueValues;
    }
}