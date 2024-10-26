
// Task 6
// Contract with an owner 
// Write a contract that will contain an "owner" variable and allow only the owner to perform certain functions.


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for owner-based access control
contract OwnerContract {
    // Variable to store the address of the owner
    address public owner;

    // Constructor that sets the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    } 

    // Function to modify the owner, available only to the current owner
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}