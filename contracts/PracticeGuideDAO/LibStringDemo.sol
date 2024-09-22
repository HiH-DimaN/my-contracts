// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/utils/Strings.sol";

contract LibStringsDemo {
  /*function testConvert(uint num) public pure returns(string memory) {
    return Strings.toString(num);*/

    using Strings for uint;
    
    function testConvert(uint num) public pure returns(string memory) {
        return num.toString();
    }
}