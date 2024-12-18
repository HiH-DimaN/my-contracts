// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ComRev
 * @dev A contract for conducting voting using the commit-reveal mechanism.
 */
contract ComRev {

    /**
     * @notice List of candidates available for voting.
     */
    address[] public candidates = [
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
        0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,
        0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    ];

    /**
     * @notice Stores hashed votes of users.
     * @dev Key is the voter's address, value is the hashed vote.
     */
    mapping(address => bytes32) public commits;

    /**
     * @notice Displays the number of votes received by each candidate.
     * @dev Key is the candidate's address, value is the number of votes.
     */
    mapping(address => uint) public votes;

    /**
     * @notice A flag indicating whether voting is stopped.
     */
    bool votingStopped;

    /**
     * @notice Stores the user's hashed vote.
     * @dev A user can submit a hashed vote only once while voting is ongoing.
     * @param _hashedVote The hashed vote (hash of candidate, secret, and user address).
     */
    function commitVote(bytes32 _hashedVote) external {
        require(!votingStopped, "Voting is closed");
        require(commits[msg.sender] == bytes32(0), "Vote already submitted");
        commits[msg.sender] = _hashedVote;
    }

    /**
     * @notice Reveals the user's vote and adds it to the voting results.
     * @dev The user must provide the candidate's address and the secret used to generate the hash for verification.
     * @param _candidate The address of the candidate being voted for.
     * @param _secret The secret used for hashing.
     */
    function revealVote(address _candidate, bytes32 _secret) external {
        require(votingStopped, "Voting is not yet closed");
        bytes32 commit = keccak256(abi.encodePacked(_candidate, _secret, msg.sender));
        require(commit == commits[msg.sender], "Hash does not match the stored value");
        delete commits[msg.sender];
        votes[_candidate]++;
    }

    /**
     * @notice Stops the voting process.
     * @dev After calling this function, users can only reveal their votes.
     */
    function stopVoting() external {
        require(!votingStopped, "Voting is already closed");
        votingStopped = true;
    }
}