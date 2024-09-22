// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

// Interface for record storage contracts
interface IRecordStorage {
    // Function to add a record to the storage
    function addRecord(Record _record) external;
}

// Abstract contract Record for storing creation time
abstract contract Record {
    uint public timeOfCreation; // Variable to store the time of creation of the record

    constructor() {
        timeOfCreation= block.timestamp; // Initialization of creation time upon construction
    }
}

// StringRecord contract for handling string records
contract StringRecord is Record {
    string public record; // Public variable to store the string record

    constructor(string memory _record) {
        record = _record; // Initialization of the string record upon construction
    }

    // Function to get the record type (in this case - string)
    function getRecordType() public pure returns(string memory) {
        return "string";
    }

    // Function to set a new record
    function setRecord(string memory _record) public {
        record = _record; // Setting a new value for the record
    }       

}

// AddressRecord contract for handling address records
contract AddressRecord is Record {
    address public record; // Public variable to store the address record

    constructor(address _record) {
        record = _record; // Initialization of the address record upon construction
    }
    
    // Function to get the record type (in this case - address)
    function getRecordType() public pure returns(string memory) {
        return "address";
    }

    // Function to set a new record
    function setRecord(address _record) public {
        record = _record; // Setting a new value for the record
    }
}

// EnsRecord contract for handling ENS domain records
contract EnsRecord is Record {
    string public domain; // Public variable to store the domain name
    address public owner; // Public variable to store the owner of the domain

    constructor(string memory _domain, address _owner) {
        domain = _domain; // Initialization of the domain name upon construction
        owner = _owner; // Initialization of the owner upon construction
    }

    // Function to get the record type (in this case - ens)
    function getRecordType() public pure returns(string memory) {
        return "ens";
    }

    // Function to set a new owner for the ENS domain
    function setOwner(address _newOwner) public {
        owner = _newOwner; // Setting a new owner for the ENS domain
    }
}

// RecordFactory contract for creating and managing records
contract RecordFactory {
    Record[] public records; // Dynamic array of records

    // Function to add an address record
    function addRecord(string memory _record) public {
        StringRecord stringRecord = new StringRecord(_record); // Creating a new address record
        records.push(stringRecord); // Adding it to the records array
    }

    // Function to add a string record
    function addRecord(address _record) public {
        AddressRecord addressRecord = new AddressRecord(_record); // Creating a new string record
        records.push(addressRecord); // Adding it to the records array
    }

}

// RecordsStorage contract for storing records and managing factories
contract RecordsStorage is Ownable, IRecordStorage {
    Record[] public records; // Dynamic array of records
    mapping(address => bool) public factories; // Mapping of factories

    // Constructor to initialize the owner
    constructor(address initialOwner) Ownable(initialOwner) {}

    // Modifier to allow only authorized factories to add records
    modifier onlyFactory() {
        require(factories[msg.sender], "Not an authorized factory");
        _;
    }
    // Function to add a record to the storage
    function addRecord(Record _record) external override onlyFactory {
        records.push(_record); // Adding the record to the records array
    }

    // Function to authorize a new factory
    function addFactory(address _factory) public onlyOwner {
        factories[_factory] = true; // Setting the factory address as authorized
    
    }
}

// BaseRecordFactory contract for creating and managing records
abstract contract BaseRecordFactory {
        IRecordStorage public recordsStorage; // Storage contract for records

        constructor(address _recordsStorage) {
            recordsStorage = IRecordStorage(_recordsStorage); // Initializing the records storage contract address
        }

        // Internal function to add a record to the storage
    function onRecordAdding(Record _record) internal {
        recordsStorage.addRecord(_record); // Calling the addRecord function of the storage contract
    }

}

// StringRecordFactory contract for creating string records
contract StringRecordFactory is BaseRecordFactory {
    constructor(address _recordsStorage) BaseRecordFactory(_recordsStorage) {}

    // Function to create and add a new string record
    function addStringRecord(string memory _record) public {
        StringRecord stringRecord = new StringRecord(_record); // Creating a new string record
        onRecordAdding(stringRecord); // Adding it to the records storage
    }
}

// AddressRecordFactory contract for creating address records
contract AddressRecordFactory is BaseRecordFactory {
    constructor(address _recordsStorage) BaseRecordFactory(_recordsStorage) {}

    // Function to create and add a new address record
    function addAddressRecord(address _record) public {
        AddressRecord addressRecord = new AddressRecord(_record); // Creating a new string record
        onRecordAdding(addressRecord); // Adding it to the records storage
    }

}

// EnsRecordFactory contract for creating ENS domain records
contract EnsRecordFactory is BaseRecordFactory {
    constructor(address _recordsStorage) BaseRecordFactory(_recordsStorage) {}

    // Function to create and add a new ENS domain record
    function addEnsRecord(string memory _domain, address _owner) public {
        EnsRecord ensRecord = new EnsRecord(_domain, _owner); // Creating a new ENS record
        onRecordAdding(ensRecord); // Adding it to the records storage
    }
}



