//SPDX-License-Identifier: GPL-3.0 

pragma solidity ^0.8.0;

contract AddresDemo {
    address myAddress;

    function setAddress(address _newAddress) public {
        myAddress = _newAddress;
    }

    function getBalance() public view returns (uint) {
        return myAddress.balance;
    }
}