// Contract with fallback function.
// Create a contract that uses the fallback function to process received ethers.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample {
    // Event for logging the receipt of ether
    event ReceivedEther(address sender, uint256 amount);

    // Callback function, called when an ether is received
    fallback() external payable {
        // Logging for receiving ether
        emit ReceivedEther(msg.sender, msg.value);
    }

    // Receive function, called when receiving ether without data
    receive() external payable {
        // Logging for receiving ether
        emit ReceivedEther(msg.sender, msg.value);
    }

}