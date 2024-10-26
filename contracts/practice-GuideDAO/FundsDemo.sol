// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract FundsDemo {
    uint public balanceReceied;

    function receiveMoney() public payable {
        balanceReceied += msg.value;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function withdrawMoney() public {
        address payable receiver = payable (msg.sender);
        receiver.transfer(this.getBalance());
    }
}

