// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Cycles {
    uint public i;
    
    function setNumber() public pure {
        for (uint x; x < 10; x++) {
            if (x == 3) {
                continue; 
            }
            if (x == 5) {
                break;
            }
        }

        uint j = 0;
        
        while (j < 10) {
        j++;
        }
    }

}