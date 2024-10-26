// Task 23 
// Contract limiting the number of function calls.
// Create a contract that will limit the number of function calls to a given value.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallLimiter {
    address public  owner; // Address of the contract owner
    uint public maxCalls;  // Maximum number of function calls
    uint public callCount; // Current number of function calls
    uint public rewardAmount; // The amount of reward for each call

    // Event that is called on each successful function call
    event FunctionCalled (address indexed caller, uint callNumber, uint reward);

    // Modifier to check that the function is called by the contract owner
    modifier onlyOwner() {
        require(owner == msg.sender, "Not the contract owner");
        _;
    }

    // Modifier to check that the current number of calls is less than the set limit
    modifier callLimit() {
        require(callCount < maxCalls, "Call limit exceeded");
        _;
    }

    // Constructor that sets the owner, the maximum number of calls and the amount of reward
    constructor(uint _maxCalls, uint _rewardAmount) payable {
        require(msg.value >= _maxCalls * _rewardAmount, "Not enough ether sent"); // Check that enough ETH has been sent for all rewards

        owner = msg.sender; // Set the owner of the contract
        maxCalls = _maxCalls; // Set the maximum number of calls
        rewardAmount = _rewardAmount; // Set the reward amount
        callCount = 0; // Initializing the call counter
    }

    // A function that can only be called a limited number of times
    function limitedFunction() public callLimit {
        callCount ++; // Increasing the call counter
        payable (msg.sender).transfer(rewardAmount); // Transferring the reward to the caller's address

        // Event call
        emit FunctionCalled(msg.sender, callCount, rewardAmount);
    }

    // Function to reset the call counter (only available to the owner)
    function resetCounter() public onlyOwner {
        callCount = 0; // Reset call counter
    }

    // Function to update the maximum number of calls (only available to the owner)
    function updateMaxCalls(uint _maxCalls) public onlyOwner {
        require(address(this).balance >= _maxCalls * rewardAmount, "Not enough ether in contract"); // Check that there are enough funds in the contract for new calls

        maxCalls = _maxCalls; // Update the maximum number of calls
    }

    // Function for updating the amount of remuneration (only available to the owner)
    function updateRewardAmount(uint _rewardAmount) public onlyOwner {
        require(address(this).balance >= _rewardAmount * maxCalls, "Not enough ether in contract"); // Check that there are enough funds in the contract for new rewards

        rewardAmount = _rewardAmount; // Update the amount of remuneration
    }

    // Function for depositing additional funds into the contract (available only to the owner)
    function deposit() public payable onlyOwner {}

    // Function for withdrawing all funds from the contract (available only to the owner)
    function withdraw() public payable onlyOwner {
        payable (owner).transfer(address(this).balance); // Transfer all funds to the owner's address
    }
}