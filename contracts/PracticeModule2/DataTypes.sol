// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract DataTypes {
    
    bool public firstBool;
    bool private secondBool = true;
    bool internal thirdBool;

    uint8 constant FIXED = 32;
    uint8 public maxVal = 255;
    uint256 public myNum;
    uint256 public myEther = 100 ether;

    // Создание мэппинга с ключом address и значениями типа uint
    mapping(address => uint) public myMap;

    // Мэппинг в мэпиинге (Nested mapping) 
    mapping(address => mapping(uint => bool)) public nested;


    //ОПЕРАТОРЫ СРАВНЕНИЯ //

    // Функция проверяет равна ли переменная с введенным значением, если "да",
    //то показывается true, если "нет" - false;

    function getBoolOne(bool argBool) external view returns (bool check) {     
       return firstBool == argBool ? true : false; // тернарный оператор
    }

    // Функция проверяет, что переменная НЕ равна с введенным значением. Если значения "не равны",
    //то показывается true, если "равны" - false;

    function getBoolTwo(bool argBool) external view returns (bool) {     
       return thirdBool != argBool ? true : false;
    }

    //Функция проверяет, что обе переменны должны быть "true". Если хоть одна из них не "true", 
    // то результатом будем "false".

    function getBoolThree(bool argBool) external view returns (bool) {     
       return firstBool && argBool ? true : false;
    }

    //Функция проверяет, что ХОТЯ БЫ одна переменная должны быть "true". Если хоть одна из них "true", 
    // то результатом будем "true".

    function getBoolFour(bool argBool) external view returns (bool) {     
       return firstBool || argBool ? true : false;
    }


    // ПРОСТЫЕ МАТЕМАТИЧЕСКИЕ ОПЕРАЦИИ //

        //Простая математическая функция
    function inc() external view returns (uint256) {     
       return (myNum+FIXED) * 10;
    }

    //Простая функция вычитания 1 из числа
    function dec() external returns (uint256) {     
       return --maxVal;
    }

    // Пример переполнения и отката транзакции, работает, если maxVal == 255
    function overFlow() external returns (uint256) {     
       return maxVal = maxVal + 1;
    }

    // Пример не безопасного перевода в другую размерность. 
    // Переводит 100 эфиров. Выполните функцию, чтобы узнать, что получилось
    function cast() external view returns (uint112) {     
       return uint64(myEther);
    }

    // ПРИМЕРЫ ВЗАИМОДЕЙСТВИЯ С МАППИНГАМИ //

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

    function getNested(address _addr1, uint _i) public view returns (bool) {
        // Получение значения из nested mapping. Получает значение bool с ключом uint для ключа address
        return nested[_addr1][_i];
    }

    function setNested(address _addr1, uint _i, bool _boo) public {
        // Устанавливаем значение в nested mapping
        nested[_addr1][_i] = _boo;
    }
}