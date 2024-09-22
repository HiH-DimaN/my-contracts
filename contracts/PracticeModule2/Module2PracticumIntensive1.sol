// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Practicum1Module2Intensiv {
    // Variables
    uint public uintVariable;
    uint private uintVariable2;
    address public owner;
    address private myAddr;
    bool public boolVariable;
    bool private myBool;
    string public stringVariablr;
    string internal myString;

    // Constants
    uint constant uintConstant = 100;

    // Mapping
    mapping(address => uint) public addressToUintMapping;

    // Arrays
    uint[3] public fixedArray;
    uint[] public dynamicArray;

    // Enum
    enum Status {Optiopn1, Option2, Option3}
    Status public status;

    // Modifiers

    // Owner verification modifier
    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }    

    // Non-zero address check modifier
    modifier nonZeroAddress(address _addr) {
        require(_addr != address(0), "Zero address");
        _;
    }

    // Events

    // Event about adding a value to the array
    event ValueChanged(uint newValue);

    // Owner change event
    event OwnerChanged(address newOwner);

    // User error
    error Unauthorized();

    // Constructor set owner and status
    constructor() {
        owner = msg.sender;
        
    }

    // Functions

    // 1. Function adding +1 to uint variable
    function incrementUint() public {
        uintVariable ++;
    }

    // 2. Function subtracting a constant from uint
    function decrementByConstant() public {
        require(uintVariable2 <= uintConstant, "Underflow risk");
        uintVariable2 -= uintConstant;
    }

    // 3. A function that takes arguments and stacks them with a constant and another uint
    function assWithArguvents(uint _value) public view returns (uint) {
        return _value + uintConstant + uintVariable;
    }

    // 4. Function that sets the value to mapping
    function setMappingValue(address _addr, uint _value) public {
        addressToUintMapping[_addr] = _value;
    }

    // 5. Function that adds 3 values to a fixed-length array
    function addToFixedArray(uint _value1, uint _value2, uint _value3) public {
        require(fixedArray.length == 3, "Array length mismatch");
        fixedArray[0] = _value1;
        fixedArray[1] = _value2;
        fixedArray[2] = _value3;
    }

    // 6. Function that removes a value from an array without changing its length
    function deleteFromFixedArray(uint index) public {
        require(index < fixedArray.length, "Index out of bounds");
        delete fixedArray[index];
    }

    // 7. Function that removes a value from an array with changing its length
    function deleteFrovDynamicArray(uint index) public {
        require(index < dynamicArray.length, "Index out of bounds");
        for (uint i = index; i < dynamicArray.length - 1; i++) {
            dynamicArray[i] = dynamicArray[i+1];
        }

        dynamicArray.pop();
    }

    // 8. Function that measures the length of an array
    function getDynamicArrayLength() public view returns (uint) {
        return dynamicArray.length;
    }

    // 9. A function that changes the address of the contract owner with checks for a null address and the current owner
    function changeOwner(address _newOwner) public onlyOwner nonZeroAddress(_newOwner) {
        owner = _newOwner;
        emit OwnerChanged(_newOwner);
    }

    // 10. Function passing in a loop and adding values 0-10 to the array
    function populateArray() public {
        for (uint i = 0; i < 10; i++) {
            dynamicArray.push(i);
        }
    }

    // 11. Function that zeroes the value in mapping and sets the 2nd option from enum
    function resetMappingAndSetStatus(address _addr) public {
        addressToUintMapping[_addr] = 0;
        status = Status.Option2;
    }

    // 12. Function that adds a value to a fixed-length array and generates an event
    function addToFixedArrayAndEmit(uint _value) public {
        require(fixedArray.length == 3, "Array length mismatch");
        fixedArray[2] = _value;
        emit ValueChanged(_value);
    }

    // 13. A function that does addition of numbers with a check that the number cannot be less than 10
    function safeAddition(uint _a, uint _b) public pure returns (uint) {
        require(_a + _b >= 10, "Result must be at least 10");
        return _a + _b;
    } 

    // 14. Function with ternary operator, outputting uint number
    function ternarnyCheck(uint _value) public pure returns (uint) {
        return _value > 10 ? _value : 10;
    }

    // 15. Function that does revert when you try to change a value in mapping
    function revertOnMappingChange(address _addr, uint _value) public {
    // Check the current value
        if (addressToUintMapping[_addr] != 0) {
            // If the value is already set, revert
            revert("Cannot change mapping value");
        }

        // Set new value
        addressToUintMapping[_addr] = _value;
    }    

    // 16. Function that outputs an array value by index
    function getArrayValue(uint index) public view returns (uint) {
        require(index < dynamicArray.length, "Index out of bounds");
        return dynamicArray[index];
    }
    
}