// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        bytes32 uid;
        string name;
        string surname;
        uint256 age;
        address from;
        uint256 votes;
    }
    mapping(bytes32 => Candidate) public candidates;
    bytes32[] public allCandidates;
    mapping(address => bool) public registeredCandidate;
    mapping(address => bytes32) public voters;
    uint public constant REGISTRATION_DURATION = 7 days;
    uint public constant VOTING_DURATION = 14 days;
    uint public immutable VOTING_STARTS_AT;
    uint public VOTING_CREATED_AT;
    address owner;

    constructor(uint _delay, address _owner) {
        VOTING_CREATED_AT = block.timestamp + _delay;
        VOTING_STARTS_AT = VOTING_CREATED_AT + REGISTRATION_DURATION;
        owner = _owner;
    }

    function vote(bytes32 _uid) external {
        if(VOTING_STARTS_AT > block.timestamp) {
            revert("Voting is not started!");
        }

        if (block.timestamp > VOTING_STARTS_AT + VOTING_DURATION) {
            revert("Voting has already ended!");
        }

        if(candidates[_uid].from == address(0)) {
            revert("Candidate doesn't exist!");
        }

        if(voters[msg.sender] != bytes32(0)) {
            revert("You've already voted!");
        }

        voters[msg.sender] = _uid;
        candidates[_uid].votes++;
    }

    function addCandidate(string memory name, string memory surname, uint age) external payable {
        if (msg.value != 1000) {
            revert("Please pay fee!");
        }

        if (block.timestamp > VOTING_CREATED_AT + REGISTRATION_DURATION) {
            // we have 7 days to register
            revert("Too late to register");
        }

        if(registeredCandidate[msg.sender]) {
            revert("You've already registered!");
        }

        registeredCandidate[msg.sender] = true;

        bytes32 uid = keccak256(abi.encode(name, surname, age, msg.sender));

        candidates[uid] = Candidate({
            uid: uid,
            name: name,
            surname: surname,
            age: age,
            from: msg.sender,
            votes: 0
        });

        allCandidates.push(uid);
    }
}