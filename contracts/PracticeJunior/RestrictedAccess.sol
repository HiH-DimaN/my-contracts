// Task 12
// Contract with limited access 
// Create a contract that only allows a user with a specific address to perform a function

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract to restrict access by address
contract RestrictedAccess {
    // Variable for storing the allowed address
    address public allowedAddress;

    // Constructor for setting the allowed address
    constructor(address _allowedAddress) {
        allowedAddress = _allowedAddress;
    }

    // Modifier for restricting access only to an authorized address
    modifier onlyAllowed() {
        require(msg.sender == allowedAddress, "Access denied");
        _;
    }

    // Function available only to the allowed address
    function restrictedFucnion() public onlyAllowed {
        // Actions available only to allowedAddress 
    }
}