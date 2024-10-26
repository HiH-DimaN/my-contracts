// Contract with nested mappings.
// Create a contract that uses nested mappings to store data.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NestedMappings {
    // Nested mapping 
    // Level 1 key - address (address)
    // Level 2 key - string
    // Value - number (uint256)
    mapping (address => mapping (string => uint256)) public data;

    // Function for setting a value in mapping
    function setValue(address _user, string memory _key, uint256 _value) public {
        data[_user][_key] = _value;
    }

    // Function for getting the value from mapping
    function getValue(address _user, string memory _key) public view returns (uint256) {
        return data[_user][_key];
    }

}