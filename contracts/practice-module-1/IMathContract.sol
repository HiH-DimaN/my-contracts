// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMathContract {

    function add(uint x, uint y) external pure returns (uint);

    function subtract(uint x, uint y) external pure returns (uint);

    function multiply(uint x, uint y) external  pure returns (uint);

    function divide(uint x, uint y ) external  pure returns (uint);

    
}