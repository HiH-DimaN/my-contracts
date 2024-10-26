// Task 13
// Contract with temporary blocking.
// Create a contract that will block the execution of a function for a certain period of time after it is called.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Contract for temporary blocking of function execution
contract TimedLock {

    // Variable to store the time of the last function call
    uint256 public lastExecuted;

    // Blocking period
    uint256 public lockTime;

    // Constructor for setting the blocking period
    constructor(uint256 _lockTime) {
        lockTime = _lockTime;
    }

    // A function that can be executed only after the blocking period expires
    function executed() public {
        require(block.timestamp > lastExecuted + lockTime, "Function is locked");
        lastExecuted = block.timestamp;
        // Function actions

    }

}