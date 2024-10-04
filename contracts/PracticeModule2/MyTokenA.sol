// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./MyERC20.sol";

/*
 * @title MyTokenA
 * @dev Контракт токена A на основе MyERC20.
 */
contract MyTokenA is MyERC20 {
    constructor() MyERC20("MyTokenA", "MTA", 18) Ownable(msg.sender) {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
}