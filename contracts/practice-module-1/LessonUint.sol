// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract LessonUint{
    
    bool public firstBool;
    uint8 constant FIXED = 32;
    uint8 public maxVal = 255;
    uint256 public myNum;
    uint256 public myEther = 100 ether;


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

    // Пример переполнения без отката, работает, если maxVal == 255
    function notOverFlow() external returns (uint256) {     
       unchecked {
        return maxVal = maxVal + 1;
       }
    }

    // Пример не безопасного перевода в другую размерность. 
    // Переводит 100 эфиров. Выполните функцию, чтобы узнать, что получилось
    function cast() external view returns (uint112) {     
       return uint64(myEther);
    }

}

