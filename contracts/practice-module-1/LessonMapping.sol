// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Mapping {
    // Создание мэппинга с ключом address и значениями типа uint
    mapping(address => uint) public myMap;

    function get(address _addr) public view returns (uint) {
        // Получение значений по ключу
        // Если значение не найдено, то функция вернет 0
        return myMap[_addr];
    }

    function set(address _addr, uint _i) public {
        // Обновление значения по ключу
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // Обнуление значения по ключу
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // Мэппинг в мэпиинге (Nested mapping) 
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // Получение значения из nested mapping. Получает значение bool с ключом uint для ключа address
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        // Устанавливаем значение в nested mapping
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint _i) public {
        //Обнуляем значение
        delete nested[_addr1][_i];
    }
}