// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LessonExternalLibrary {
    function substract(uint a, uint b) external pure returns (uint) {
        require(a > b, "Subtraction underflow");
        return a - b;
    }
}