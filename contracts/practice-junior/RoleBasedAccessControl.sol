// Task 27 
// Contract with role validation.
// Write a contract that will check the user's role before executing a function.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the AccessControl contract from the OpenZeppelin library
import "@openzeppelin/contracts/access/AccessControl.sol";

// Define a RoleBasedAccessControl contract that inherits the role management functionality from AccessControl
contract RoleBasedAccessControl is AccessControl {
    // Constants for defining roles using the hash function keccak256
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant USER_ROLE = keccak256("USER_ROLE");

    // Contract constructor that is called when the contract is deployed
    constructor(address initialAdmin) {
        // Assign ADMIN_ROLE to the specified address (administrator)
        _grantRole(ADMIN_ROLE, initialAdmin);
        // Assign USER_ROLE to the specified address (user)
        _grantRole(USER_ROLE, initialAdmin);
    }

    // Function available only to users with the ADMIN_ROLE role
    function adminFunction() public onlyRole(ADMIN_ROLE) {
        // Logic available only to administrators
    }

    // Function available only to users with the USER_ROLE role
    function userFunction() public onlyRole(USER_ROLE) {
        // Logic available only to users
    }

    // Function for adding a new user (assigning the USER_ROLE role)
    function addUser(address account) public onlyRole(ADMIN_ROLE) {
        // Assign USER_ROLE to the specified address
        grantRole(USER_ROLE, account);
    }

    // Function for deleting a user (deleting the USER_ROLE role)
    function removeUser(address account) public onlyRole(ADMIN_ROLE) {
        // Delete the USER_ROLE role at the specified address
        revokeRole(USER_ROLE, account);
    }
}