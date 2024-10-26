// Contract with data transfer to the callback function (receive).
// Create a contract that uses the receive function to process received ethers.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Receive {
    // Public variable to store the contract balance
    uint256 public contractBalance;

    // Event for logging the receipt of ether
    event LogReceivedEther(address sender, uint256 amount);

    // Receive function for processing the received ethers
    receive() external payable {
        contractBalance += msg.value; // Increase the contract balance
        // Logging the event
        emit LogReceivedEther(msg.sender, msg.value);
    }

    // Function for receiving the contract balance
    function getBalance() public view returns(uint256) {
        return contractBalance;
    }
}