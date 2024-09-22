// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./BaseContract.sol";  // Импорт BaseContract

// Контракт наследует BaseContract
contract DerivedContract is BaseContract {

    // Переопределение функции increment с дополнительной логикой
    function increment() public override {
        count += 2;  // Увеличиваем count на 2 вместо 1
    }
}
