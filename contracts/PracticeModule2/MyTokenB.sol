// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./MyERC20.sol";

/*
 * @title MyTokenB
 * @dev Контракт токена B на основе MyERC20.
 */
contract MyTokenB is MyERC20 {
    constructor() MyERC20("MyTokenB", "MTB", 18) Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}