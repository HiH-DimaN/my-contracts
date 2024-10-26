// SPDX-License-Identifier: MTI

pragma solidity ^0.8.0;

contract Module1Lesson2 {
    mapping(address => uint) public payments;

    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function reciveFunds() public payable {
        payments[msg.sender] = msg.value;
    }

    function transferTo(address targetAddr, uint amount) public {
        address payable _to = payable (targetAddr);
        _to.transfer(amount);
    } 

    function getBalance(address targetAddr) public view returns (uint) {
        // Возвращаем баланс указанного адреса
        return targetAddr.balance;
    }

    
}