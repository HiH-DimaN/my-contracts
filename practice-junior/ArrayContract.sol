// Task 22
// Contract an event when an element is added to an array.
// Write a contract that will generate an event when a new element is added to an array.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayContract {
    // Array declaration
    uint[] public array;

    // Event declaration
    event AddingElement(uint element);

    // Function for adding a new element to the array
    function addArray(uint _newElement) public {
        // Adding an element to the array
        array.push(_newElement);

        // Generating the ElementAdded event
        emit AddingElement(_newElement);
    }

    // Function to get all elements of the array
    function getArray() public view returns (uint[] memory) {
        return array;
    }
}