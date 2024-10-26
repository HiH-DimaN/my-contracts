//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Demo {

  uint public a;
  address public owner;
  
  constructor(address _owner) {
    owner = _owner;
  }

  function run(uint _a) external payable  { 
    require(owner == msg.sender, "not at owner!"); 

    a = _a;   
  } 
}