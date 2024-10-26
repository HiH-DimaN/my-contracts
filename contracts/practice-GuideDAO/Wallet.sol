// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./SharedWallet.sol";

contract Wallet is SharedWallet{

    // Событие, сигнализирующее о снятии средств
    event MoneyWithdrawn(address indexed _to, uint _amount);

    // Событие, сигнализирующее о получении средств
    event MoneyReceived(address indexed _from, uint _amount);

    // Передаем аргумент в конструктор SharedWallet
    constructor(address _owner) SharedWallet(_owner) {}

    // Функция для снятия средств с кошелька
    function withdrawMoney(uint _amount) public ownerOrWithinLimits(_amount){
        require(_amount <= address(this).balance, "Not enough funds to withdraw!");

        Member storage member = members[_msgSender()];

        // Проверяем, не является ли отправитель администратором, и уменьшаем его лимит
        if(!isOwner() && !member.is_admin) {
            deduceFromLimit(_msgSender(), _amount); 
        }    

        // Переводим средства на адрес отправителя
        address payable _to = payable(_msgSender());
        _to.transfer(_amount);

        // Запускаем событие о снятии средств
        emit MoneyWithdrawn(_to, _amount);
    }

    // Функция для отправки средств на другой адрес
    function sendToContract(address _to) public payable {
        address payable to = payable (_to);
        to.transfer(msg.value);

        // Запускаем событие о получении средств
        emit MoneyReceived(_msgSender(), msg.value);
    }

    // Функция для получения баланса контракта
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Функция-заглушка для принятия средств
    fallback() external payable { }

    // Функция-заглушка для принятия средств
    receive() external payable { 
        emit MoneyReceived(_msgSender(), msg.value); 
    }
}