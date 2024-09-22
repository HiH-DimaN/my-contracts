// Task 5
// Contract with a dictionary of addresses.
// Create a contract that stores a dictionary of addresses and allows new address-value pairs to be added.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for storing a dictionary of addresses and values
contract AddressMap {
    // Dictionary for storing addresses and values
    mapping (address => uint256) public balances;

    // Function for setting a value for an address
    function setBalance(address addr, uint256 balance) public {
        balances[addr] = balance;
    }

    // Function to get a value for an address
    function getBalance(address addr) public view returns(uint256) {
        return balances[addr];
    }
}