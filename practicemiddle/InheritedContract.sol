// Contract for inheritance.
// Write a base contract and a contract that inherits it and extends the functionality.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseContract.sol";

// Inherited contract
contract InheritedContract is BaseContract {
     // Text
    string  public text;

    // Constructor that calls the constructor of the base contract and initializes the text
    constructor(uint _initialValue, string memory _initialText) 
        BaseContract (_initialValue) 
    {
            text = _initialText;
        
    }
    // Function for setting the text
    function setText(string memory _newText) public {
        text = _newText;
    }

    // Function to get the text
    function getText() public view returns(string memory) {
        return text;
    }

    // Overriding the setValue function from the base contract
    function setValue(uint _newValue) public override {
        // Additional logic before setting the value
        require(_newValue > 10, "Value must be greater than 10");
        super.setValue(_newValue);
    }

}