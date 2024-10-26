// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Подключаем внешнюю библиотеку
import "./LessonExternalLibrary.sol";
// Подключаем внутреннюю библиотеку
import "./LessonInternalLibrary.sol";

contract UseLibraries {
    // Подключаем LessonExternalLibrary к типу данных uint
    using LessonExternalLibrary for uint;
    // Подключаем LessonInternalLibrary к типу данных uint
    using LessonInternalLibrary for uint;

    // Пример функции, использующей внешнюю библиотеку
    function subtractNumbers(uint a, uint b) public pure returns (uint) {
        return a.substract(b); // вызываем функцию из LessonExternalLibrary
    }

    // Пример функции, использующей внутреннюю библиотеку
    function multiplyNumbers(uint a, uint b) public pure returns (uint) {
        return a.multiply(b); // вызываем функцию из LessonInternalLibrary
    }
}