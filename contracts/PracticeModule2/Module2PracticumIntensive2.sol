// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Practicum {
    // Variables
    // 1. Nested mapping
    mapping (address => mapping (uint => uint)) public nestedMapping;

    // 2. Mapping with structure
    struct Person {
        string name;
        uint age;
    }

    mapping (address => Person) public personMapping;

    // 3. A structure that will have another structure in it
    struct Job {
        string title;
        uint salary;
    }

    struct Employe {
        Person person;
        Job job;
    }

    // 4. Structure with mapping inside
    struct Group {
        string groupName;
        mapping (address => Person) members;
    }

    mapping (uint => Group) public groups;

    // 5. Array of structures
    Person[] public personsArray;

    // 6. mapping with an array of structures
    mapping (address => Person[]) public personArrayMapping;
    
    // Functions
    // 1. adding a value in array mapping
    function addToPersonArrayMapping(address _key, string memory _name, uint _age) public {
        personArrayMapping[_key].push(Person(_name, _age));
    }

    // 2. Deleting a value in array mapping
    function removeFromPersonArrayMapping(address _key, uint _index) public {
        require(_index < personArrayMapping[_key].length, "Index out of bounds");
        for (uint i = _index; i < personArrayMapping[_key].length - 1; i++) {
            personArrayMapping[_key][i] = personArrayMapping[_key][i+1];

        }
        personArrayMapping[_key].pop();
    }

    // 3. Adding a value in a nested mapping
    function addToNestedMapping(address _key1, uint _key2, uint _value) public {
        nestedMapping[_key1][_key2] = _value;
    }

    // 4. Deleting a value in a nested mapping
    function removeFromNestedMapping(address _key1, uint _key2) public {
        delete nestedMapping[_key1][_key2];
    }

   // 5. Adding a struct value in a mapping
    function addToPersonMapping(address _key, string memory _name, uint _age) public {
        personMapping[_key] = Person(_name, _age);
    }

   // 6. Adding a value to a mapping located in struct
    function addToGroup(uint _groupId, address _memberAddress, string memory _name, uint _age) public {
        Group storage group = groups[_groupId];
        group.members[_memberAddress] = Person(_name, _age);
    }

    // 7. Calling another function and calculations
    function computeSumFromNestedMapping(address _key1, uint _key2, uint _value) public view returns (uint) {
        uint currentValue = getNestedMappingValue(_key1, _key2);
        return currentValue + _value;
    }

    function getNestedMappingValue(address _key1, uint _key2) public view returns (uint) {
        return nestedMapping[_key1][_key2];
    }

}