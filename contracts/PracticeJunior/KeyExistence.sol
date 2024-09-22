// Task 19
// A contract to check if a key exists in a mapping.
//Create a contract to check if a key exists in mapping.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract KeyExistence {

    // Declare a mapping
    mapping (address => uint) public balances;

    // Declare an additional mapping to keep track of existing keys
    mapping (address => bool) public keyExists;

    // Function to add data to the mapping
    function addBalance(address _address, uint _balance) public {
        balances[_address] = _balance;
        keyExists[_address] = true;
    }

    // Function to check if the key exists
    function exists(address _address) public view returns (bool) {
        return keyExists[_address];
    }


}

