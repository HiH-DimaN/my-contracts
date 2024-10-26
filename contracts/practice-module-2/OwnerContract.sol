// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Контракт для хранения и изменения адреса владельца
contract OwnerContract {
    address public owner;

    // Функция для изменения адреса владельца
    function setOwner(address _owner) public {
        owner = _owner;
    }
}