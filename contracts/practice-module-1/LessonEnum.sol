// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Enum {
    // Создание enum с опциями для "Доставки"
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    enum Order {
        Received,
        Sent,
        Delivered
    }

    Order public order;

    // Значение по умолчанию - первый элемен в enum - Pending

    // Установка enum в переменную
    Status public status;

    // Возвращает индекс опций
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4

    function get() public view returns (Status) {
        //Получение значения переменной
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        //Установка опций в переменную
        status = _status;
    }

    // Обновление опции в переменной напрямую
    function cancel() public {
        status = Status.Canceled;
    }

    // Обнуление переменной - установка опции по умолчанию - Pending
    function reset() public {
        delete status;
    }
}