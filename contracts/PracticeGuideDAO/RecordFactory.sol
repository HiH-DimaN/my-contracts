// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

abstract contract Record {
    uint256 public timeOfCreation; // Variable to store the creation time of the record

    // Constructor to set the creation time
    constructor(uint256 _timeOfCreation) {
        timeOfCreation = _timeOfCreation;
    }

    // Virtual function to get the record type (to be overridden in child contracts)
    function getRecordType() public virtual pure returns (string memory);

    // Function to set a new record (to be implemented in child contracts)
    // function setRecord() public virtual;
}

contract StringRecord is Record {
    string public record; // Variable to store the string record

    // Constructor to initialize the creation time and the string record
    constructor(uint256 _timeOfCreation, string memory _record)
        Record(_timeOfCreation)
    {
        record = _record;
    }

    // Implementation of the function to get the record type (returns "string")
    function getRecordType() public pure override returns (string memory) {
        return "string";
    }

    // Function to set a new string record
    function setRecord(string memory newRecord) public {
        record = newRecord;
    }
}

contract AddressRecord is Record {
    address public record; // Variable to store the address record

    // Constructor to initialize the creation time and the address record
    constructor(uint256 _timeOfCreation, address _record)
        Record(_timeOfCreation)
    {
        record = _record;
    }

    // Implementation of the function to get the record type (returns "address")
    function getRecordType() public pure override returns (string memory) {
        return "address";
    }

    // Function to set a new address record
    function setRecord(address newRecord) public {
        record = newRecord;
    }
}

contract RecordFactory {
    struct RecordEntry {
        uint256 timeOfCreation; // Time of creation of the record
        address recordAddress; // Address of the record contract
        string recordType; // Type of the record ("string" or "address")
    }

    RecordEntry[] public records; // Array of all added records

    // Event that is emitted when a new record is added
    event RecordAdded(uint256 indexed timeOfCreation, address indexed recordAddress, string recordType);

    // Function to create a new string record
    function createStringRecord(string memory record) public {
        StringRecord newContract = new StringRecord(block.timestamp, record);
        records.push(RecordEntry(block.timestamp, address(newContract), "string"));
        emit RecordAdded(block.timestamp, address(newContract), "string");
    }

    // Function to create a new address record
    function createAddressRecord(address record) public {
        AddressRecord newContract = new AddressRecord(block.timestamp, record);
        records.push(RecordEntry(block.timestamp, address(newContract), "address"));
        emit RecordAdded(block.timestamp, address(newContract), "address");
    }

    // Function to get the count of records in the array
    function getRecordsCount() public view returns (uint256) {
        return records.length;
    }

    // Function to get the data of a specific record by index
    function getRecordAtIndex(uint256 index) public view returns (uint256 timeOfCreation, address recordAddress, string memory recordType) {
        require(index < records.length, "Index out of bounds");
        RecordEntry memory entry = records[index];
        return (entry.timeOfCreation, entry.recordAddress, entry.recordType);
    }
}