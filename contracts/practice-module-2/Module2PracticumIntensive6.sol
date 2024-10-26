// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Module2PracticumIntensive6 {
    // Variables
    uint public myUint;          // Variable of type uint
    address public owner;        // Variable of type address
    bool public myBool;          // Variable of type bool
    
    // Constant and immutable variable
    uint256 public constant MY_CONSTANT = 100;  // Constant
    uint256 public immutable MY_IMMUTABLE;      // Immutable variable

    // Mapping
    mapping(address => uint256) public balances; // Simple mapping

    // Dynamic array
    uint[] public dynamicArray;

    // Nested mapping
    mapping(address => mapping(uint256 => bool)) public nestedMapping;

    // Mapping with a structure
    mapping(address => UserInfo) public userInfos;

    // Structures:
    // 1. Structure of the customary
    struct NestedStruct {
        uint256 id;
        string data;
    }

    // 2. Nested Structure
    struct UserInfo {
        uint256 balance;
        NestedStruct nestedData;
    }

    // Array of structures
    UserInfo[] public usersArray;

    // Modifiers
    // 1. Modifier owner verification 
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }
    // 2. Modifier to check the null address 
    modifier nonZeroAddress(address _addr) {
        require(_addr != address(0), "Address is zero");
        _;
    }

    // Constructor that sets the immutable variable
    constructor(uint256 _immutableValue) {
        owner = msg.sender;
        MY_IMMUTABLE = _immutableValue;
    }

    // Functions:
    // 1. Function to change the contract owner's address
    function changeOwner(address newOwner) public onlyOwner nonZeroAddress(newOwner) {
        owner = newOwner;
    }

    // 2. Function to add a value to the dynamic array
    function addToArray(uint256 value) public {
        dynamicArray.push(value);
    }

    // 3. Function to remove a value from the dynamic array and reduce its length
    function removeFromArray(uint256 index) public {
        require(index < dynamicArray.length, "Index out of bounds");
        dynamicArray[index] = dynamicArray[dynamicArray.length - 1]; // Replace with the last element
        dynamicArray.pop(); // Reduce the array length
    }

    // 4. Function to add a value to the nested mapping
    function addToNestedMapping(address _addr, uint256 _key, bool _value) public {
        nestedMapping[_addr][_key] = _value;
    }

    // 5. Function to remove a value from the nested mapping
    function removeFromNestedMapping(address _addr, uint256 _key) public {
        delete nestedMapping[_addr][_key];
    }

    // 6. Function to add a value to the mapping with a structure
    function addToUserInfo(address _user, uint256 _balance, uint256 _id, string memory _data) public {
        userInfos[_user].balance = _balance;
        userInfos[_user].nestedData = NestedStruct({id: _id, data: _data});
    }

    // 7. Function to add a value to the array of structures
    function addUserToArray(uint256 _balance, uint256 _id, string memory _data) public {
        UserInfo memory newUser = UserInfo({
            balance: _balance,
            nestedData: NestedStruct({id: _id, data: _data})
        });
        usersArray.push(newUser);
    }

    // 8. Function to log that a user has received Ether in a simple mapping
    function logEtherReceived(address _user) public payable {
        require(msg.value > 0, "No ether sent");
        balances[_user] += msg.value;
    }
}
