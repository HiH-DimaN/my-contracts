// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MathContract {
    // Function addition
    function add(uint x, uint y) public pure returns (uint) {
        return x + y;
    }

    // Function subtraction
    function subtract(uint x, uint y) public pure returns (uint) {
        require(x > y, "Underflow error");
        return x - y;
    }

    // Function multiply
    function multiply(uint x, uint y) public pure returns (uint) {
        return x * y;
    }

    // Function divide
    function divide(uint x, uint y ) public pure returns (uint) {
        require(y > 0, "Cannot divide by zero");
        return x / y;
    }


}