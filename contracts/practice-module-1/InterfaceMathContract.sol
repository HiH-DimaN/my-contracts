// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IMathContract.sol";

contract InterfacrMathContract {
    IMathContract mathContract;

    constructor(address _mathContractAddress) {
        mathContract = IMathContract(_mathContractAddress);
    }

    // Function addition
    function addNumber(uint a, uint b) public view returns (uint) {
        return mathContract.add(a, b);
    }

    // Function subtraction
    function subtractNumber(uint a, uint b) public view returns (uint) {
        return mathContract.subtract(a, b);
    }

    // Function multiply
    function multiplyNumber(uint a, uint b) public view returns (uint) {
        return mathContract.multiply(a, b);
    }

    // Function divide
    function divideNumber(uint a, uint b) public view returns (uint){
        return  mathContract.divide(a, b);

    } 
}