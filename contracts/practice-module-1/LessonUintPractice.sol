// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LessonUintPractice{
    
    // Написать две булевых переменных
    bool public varBool1;
    bool public varBool2 = true;


    // Написать 4 uint переменных: одна должна быть константой, две - с различными размерностями, 1 - пустую;
    uint8 constant FIXED = 32;
    uint256 public myVar = 738;
    uint8 public secVar = 58;
    uint public threeVar; 


    //Прибавить к переменной uint единицу
    function inc() external returns (uint256) {     
       return myVar++;
    }

    //Вывести максимальное значение uint112
    function showMax() external pure returns (uint256) {     
       return type(uint112).max;
    }

    //Вычесть из переменной константу, если константа меньше
    // Сложить переменную и константу, если константа больше
    function incVar() external view returns(uint256) {
        return (FIXED < secVar ? secVar - FIXED : secVar + FIXED);
    }

    //Написать условие в if, с использованием своих переменных, чтобы получить значение true
    function getTrue() external view returns(bool) {
        if(myVar > threeVar) {
            return true;
        } else {
            return false;
        }
    }
}

