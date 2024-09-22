// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Destroy {

    address owner; 
    address payable _to;
    address [] public myAddr;
    bool private active = true;

    constructor() {
        owner = msg.sender;
        _to = payable(owner); // Установить адрес назначения по умолчанию
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Is not the owner.");
        _;
    }

    modifier onlyWhenActive() {
        require(active, "Contract is not active");
        _;
    }

    function checkBalance(address[100] memory _array) public onlyWhenActive {
        for (uint i = 0; i < _array.length; i++) {
            if (_array[i].balance > 3) { 
                myAddr.push(_array[i]);
            }
            if (myAddr.length > 30) {
                deactivateContract();
                break; // Завершаем цикл после деактивации контракта
            }    
        } 
    }

    function deactivateContract() internal onlyOwner {
        require(active, "Contract is already deactivated");

        // Перевод оставшегося эфира на указанный адрес
        (bool success, ) = _to.call{value: address(this).balance}("");
        require(success, "Transfer failed");

        // Деактивация контракта
        active = false;
    }

    // Функция для изменения адреса назначения
    function setRecipient(address payable newRecipient) external onlyOwner {
        _to = newRecipient;
    }

    // Функция для пополнения контракта эфиром
    receive() external payable {}
}
