// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Array {
    // Способы создания массивов
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    // Массив с фиксированной длинной, где все значения = 0
    uint[10] public myFixedSizeArr;

    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    // Так можно получить весь массив. 
    // Однако нужно избегать такого решения со слишком большими массивами,
    // так как они могут использовать весь газ и обвалить транзакцию
    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function push(uint i) public {
        // Добавление значения в массив. 
        // В данном случае можно добавить число
        arr.push(i);
    }

    function pop() public {
        // Удаление последнего элемента из массива
        // Также уменьшает его длину
        arr.pop();
    }

    //Получение длины массива
    function getLength() public view returns (uint) {
        return arr.length;
    }

    function remove(uint index) public {
        // Обнуление значения по индексу
        // Не изменяет длину массива
        delete arr[index];
    }

    function examples() external pure {
        // Так создаются массивы с фиксированной длиной в функциях
        // Массив с динамической длиной в функции создать невозможно
        uint[] memory a = new uint[](5);
        a[0] = 1;
    }
}