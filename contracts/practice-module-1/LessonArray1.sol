// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Array
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с массивами.
 */
contract Array {
    // Способы создания массивов
    uint[] public arr; // Динамический массив типа uint
    uint[] public arr2 = [1, 2, 3]; // Динамический массив с инициализированными значениями
    // Массив с фиксированной длинной, где все значения = 0
    uint[10] public myFixedSizeArr; // Массив с фиксированной длиной (10 элементов)

    /**
     * @dev Функция получения элемента массива по индексу.
     * @param i Индекс элемента.
     * @return Значение элемента по индексу.
     */
    function get(uint i) public view returns (uint) {
        return arr[i]; // Возвращаем значение элемента по индексу
    }

    /**
     * @dev Функция получения всего массива.
     * @return Массив.
     */
    function getArr() public view returns (uint[] memory) {
        return arr; // Возвращаем весь массив
    }

    /**
     * @dev Функция добавления элемента в массив.
     * @param i Новое значение.
     */
    function push(uint i) public {
        // Добавление значения в массив. 
        // В данном случае можно добавить число
        arr.push(i); // Добавляем значение в массив
    }

    /**
     * @dev Функция удаления последнего элемента из массива.
     */
    function pop() public {
        // Удаление последнего элемента из массива
        // Также уменьшает его длину
        arr.pop(); // Удаляем последний элемент
    }

    /**
     * @dev Функция получения длины массива.
     * @return Длина массива.
     */
    function getLength() public view returns (uint) {
        return arr.length; // Возвращаем длину массива
    }

    /**
     * @dev Функция удаления элемента из массива по индексу.
     * @param index Индекс элемента, который нужно удалить.
     */
    function remove(uint index) public {
        // Обнуление значения по индексу
        // Не изменяет длину массива
        delete arr[index]; // Удаляем значение по индексу
    }

    /**
     * @dev Функция демонстрации создания массивов с фиксированной длиной.
     */
    function examples() external pure {
        // Так создаются массивы с фиксированной длиной в функциях
        // Массив с динамической длиной в функции создать невозможно
        uint[] memory a = new uint[](5); // Создаем массив с фиксированной длиной (5 элементов)
        a[0] = 1; // Присваиваем значение первому элементу
    }
}