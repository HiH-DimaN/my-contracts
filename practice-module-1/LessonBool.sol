// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LessonBool {
    
    bool public firstBool; // state variables, public - модификатор доступа, доступность из любого места, как внутри контракта, так и извне.
    bool private secondBool = true; // state variables, private - модификатор доступа, доступность только внутри контракта, в котором она объявлены. Даже дочерние контракты не имеют к ней доступа.
    bool internal thirdBool; // state variables, internal - модификатор доступа, доступность внутри контракта и во всех дочерних контрактах.

    bool public ang = true;
    bool private analog = false;
    bool internal decl = true;

    // Функция проверяет равна ли переменная с введенным значением, если "да",
    //то показывается true, если "нет" - false;

    function getBoolOne(bool argBool) external view returns (bool check) {     
       return firstBool == argBool ? true : false;
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

    function getBoolFour() external view returns (bool) {     
       return firstBool || ang ? true : false;
    }

    //!!! Важно понимать, что если первая переменная с оператором || будет "true", то проверка
    // не дойдет до второй переменной! Поэтому проверяйте значения главных данных в начале!
}