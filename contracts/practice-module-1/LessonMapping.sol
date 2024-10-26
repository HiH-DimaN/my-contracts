// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Mapping
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с мэппингом.
 */
contract Mapping {
    // Создание мэппинга с ключом address и значениями типа uint
    mapping(address => uint) public myMap; // Мэппинг для хранения значений uint по ключам address

    /**
     * @dev Функция получения значения по ключу в мэппинге.
     * @param _addr Ключ в мэппинге (адрес).
     * @return Значение по ключу.
     */
    function get(address _addr) public view returns (uint) {
        return myMap[_addr]; // Возвращаем значение по ключу
    }

    /**
     * @dev Функция установки значения по ключу в мэппинге.
     * @param _addr Ключ в мэппинге (адрес).
     * @param _i Новое значение.
     */
    function set(address _addr, uint _i) public {
        myMap[_addr] = _i; // Установка значения по ключу
    }

    /**
     * @dev Функция удаления значения по ключу в мэппинге.
     * @param _addr Ключ в мэппинге (адрес).
     */
    function remove(address _addr) public {
        delete myMap[_addr]; // Удаление значения по ключу
    }
}

/**
 * @title NestedMapping
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с вложенным мэппингом.
 */
contract NestedMapping {
    // Мэппинг в мэпиинге (Nested mapping) 
    mapping(address => mapping(uint => bool)) public nested; // Вложенный мэппинг: address -> uint -> bool

    /**
     * @dev Функция получения значения из вложенного мэппинга.
     * @param _addr1 Ключ верхнего уровня (адрес).
     * @param _i Ключ нижнего уровня (uint).
     * @return Значение из вложенного мэппинга (bool).
     */
    function get(address _addr1, uint _i) public view returns (bool) {
        return nested[_addr1][_i]; // Возвращаем значение из вложенного мэппинга
    }

    /**
     * @dev Функция установки значения в вложенном мэппинге.
     * @param _addr1 Ключ верхнего уровня (адрес).
     * @param _i Ключ нижнего уровня (uint).
     * @param _boo Новое значение (bool).
     */
    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo; // Установка значения в вложенный мэппинг
    }

    /**
     * @dev Функция удаления значения из вложенного мэппинга.
     * @param _addr1 Ключ верхнего уровня (адрес).
     * @param _i Ключ нижнего уровня (uint).
     */
    function remove(address _addr1, uint _i) public {
        delete nested[_addr1][_i]; // Удаление значения из вложенного мэппинга
    }
}