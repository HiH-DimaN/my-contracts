// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title LessonBool
 * @author HiH_DimaN
 * @notice Контракт для демонстрации работы с типом данных `bool` в Solidity.
 */
contract LessonBool {
    
    bool public firstBool; // Переменная типа bool с модификатором доступа `public` (доступна извне)
    bool private secondBool = true; // Переменная типа bool с модификатором доступа `private` (доступна только внутри контракта)
    bool internal thirdBool; // Переменная типа bool с модификатором доступа `internal` (доступна внутри контракта и в дочерних контрактах)

    bool public ang = true; // Еще одна переменная типа bool с модификатором доступа `public`
    bool private analog = false; // Еще одна переменная типа bool с модификатором доступа `private`
    bool internal decl = true; // Еще одна переменная типа bool с модификатором доступа `internal`

    /**
     * @dev Функция проверки равенства переменной `firstBool` и переданного аргумента.
     * @param argBool Значение для сравнения.
     * @return check true, если `firstBool` равно `argBool`, иначе false.
     */
    function getBoolOne(bool argBool) external view returns (bool check) {     
       return firstBool == argBool ? true : false; // Проверяем равенство `firstBool` и `argBool`
    }

    /**
     * @dev Функция проверки неравенства переменной `thirdBool` и переданного аргумента.
     * @param argBool Значение для сравнения.
     * @return true, если `thirdBool` не равно `argBool`, иначе false.
     */
    function getBoolTwo(bool argBool) external view returns (bool) {     
       return thirdBool != argBool ? true : false; // Проверяем неравенство `thirdBool` и `argBool`
    }

    /**
     * @dev Функция проверки, что обе переменные (`firstBool` и `argBool`) равны `true`.
     * @param argBool Значение для сравнения.
     * @return true, если обе переменные равны `true`, иначе false.
     */
    function getBoolThree(bool argBool) external view returns (bool) {     
       return firstBool && argBool ? true : false; // Проверяем, что обе переменные равны `true`
    }

    /**
     * @dev Функция проверки, что хотя бы одна из переменных (`firstBool` или `ang`) равна `true`.
     * @return true, если хотя бы одна переменная равна `true`, иначе false.
     */
    function getBoolFour() external view returns (bool) {     
       return firstBool || ang ? true : false; // Проверяем, что хотя бы одна переменная равна `true`
    }

    //!!! Важно понимать, что если первая переменная с оператором || будет "true", то проверка
    // не дойдет до второй переменной! Поэтому проверяйте значения главных данных в начале!
}
