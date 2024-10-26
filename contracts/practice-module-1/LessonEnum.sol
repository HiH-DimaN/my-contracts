// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Enum
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с типом данных `enum` в Solidity.
 */
contract Enum {
    // Создание enum с опциями для "Доставки"
    enum Status {
        Pending, // Ожидание
        Shipped, // Отправлено
        Accepted, // Принято
        Rejected, // Отклонено
        Canceled // Отменено
    }

    enum Order {
        Received, // Получено
        Sent, // Отправлено
        Delivered // Доставлено
    }

    Order public order; // Переменная типа Order

    // Значение по умолчанию - первый элемент в enum - Pending

    // Установка enum в переменную
    Status public status; // Переменная типа Status

    /**
     * @dev Функция для получения текущего значения переменной `status`.
     * @return Текущее значение переменной `status`.
     */
    function get() public view returns (Status) {
        //Получение значения переменной
        return status; // Возвращаем текущее значение
    }

    /**
     * @dev Функция для установки значения переменной `status`.
     * @param _status Новое значение для переменной `status`.
     */
    function set(Status _status) public {
        //Установка опций в переменную
        status = _status; // Устанавливаем новое значение
    }

    /**
     * @dev Функция для обновления значения переменной `status` на `Canceled`.
     */
    function cancel() public {
        status = Status.Canceled; // Устанавливаем значение `Canceled`
    }

    /**
     * @dev Функция для сброса значения переменной `status` в значение по умолчанию - `Pending`.
     */
    function reset() public {
        delete status; // Сбрасываем значение переменной
    }
}