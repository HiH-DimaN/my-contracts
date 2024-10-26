// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractThree {
    uint public result;

    // Функция для выполнения вычислений, складывает два числа
    function doCalculation(uint a, uint b) public returns (uint) {
        result = a + b;
        return result;
    }
}

contract ContractOne {
    address public contractThree;
    uint public result;

    // Конструктор, принимающий адрес контракта ContractThree
    constructor(address _contractThree) {
        contractThree = _contractThree;
    }

    // Функция для получения эфира
    receive() external payable {}


    // Fallback функция, которая использует delegatecall для вызова функций в ContractThree
    fallback() external payable {
        // Логируем вызов fallback функции
        emit FallbackCalled(msg.data);

        // Вызов delegatecall
        (bool success, bytes memory data) = contractThree.delegatecall(msg.data);
        require(success, "Delegatecall failed");

        // Логируем результат вызова delegatecall
        emit DelegatecallResult(success, data);

        // Если функция возвращает результат, декодируем и сохраняем его
        if (data.length > 0) {
            result = abi.decode(data, (uint));
        }
    }

    // События для логирования
    event FallbackCalled(bytes data);
    event DelegatecallResult(bool success, bytes data);
}

contract ContractTwo {
    // Функция для вызова fallback функции в ContractOne
    function callContractOne(address contractOneAddress, uint a, uint b) public returns (bytes memory) {
        // Кодируем вызов функции doCalculation с параметрами a и b
        bytes memory payload = abi.encodeWithSignature("doCalculation(uint256,uint256)", a, b);
        
        // Вызываем fallback функцию в ContractOne
        (bool success, bytes memory returnData) = contractOneAddress.call{value: 0}(payload);
        require(success, "Call to ContractOne failed");
        
        return returnData;
    }
}





