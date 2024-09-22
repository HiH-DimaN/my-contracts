// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Базовый контракт
contract BaseContract {
    int public count;

    // Функция для инкремента значения переменной count
    function increment() public virtual {
        count += 1;
    }

    // Низкоуровневая функция для обновления переменной owner в OwnerContract
    function updateOwner(address _ownerContract, address _newOwner) public {
        // Создаем данные для вызова функции setOwner(address) в OwnerContract
        bytes memory payload = abi.encodeWithSignature("setOwner(address)", _newOwner);

        // Выполняем низкоуровневый вызов
        (bool success, ) = _ownerContract.call(payload);
        require(success, "Call to OwnerContract failed");
    }
}
