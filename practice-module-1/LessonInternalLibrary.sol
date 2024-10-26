// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LessonInternalLibrary {
    function multiply(uint a, uint b) internal pure returns (uint) {
        return a * b;
    }
}