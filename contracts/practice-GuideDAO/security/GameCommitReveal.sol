//SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

/**
 * @title GameCommitRevaal
 * @author HiH_DimaN
 * @notice Контракт для игры, где игроку необходимо предоставить хэш секретного числа, а затем раскрыть его.
 */
contract GameCommitRevaal {
    /**
     * @dev Секретное число, которое игрок должен угадать.
     */
    uint256 private secretNumber; // Секретное число, которое игрок должен угадать

    /**
     * @dev Хэш секретного числа.
     */
    bytes32 public hashedSecretNumber; // Хэш секретного числа

    /**
     * @dev Конструктор контракта.
     * @param _hashedSecretNumber Хэш секретного числа.
     */
    constructor(bytes32 _hashedSecretNumber) {
        hashedSecretNumber = _hashedSecretNumber; // Устанавливаем хэш секретного числа
    }

    /**
     * @dev Функция для раскрытия секретного числа.
     * @param _secretNumber Секретное число, которое игрок должен угадать.
     * @param _salt Соль, используемая для генерации хэша.
     */
    function reveal(uint _secretNumber, bytes32 _salt) external {
        bytes32 commit = keccak256(abi.encodePacked(msg.sender, _secretNumber, _salt)); // Генерируем хэш из адреса отправителя, секретного числа и соли

        require(commit == hashedSecretNumber, "invalid reveal!"); // Проверяем, что хэш совпадает с ранее установленным хэшем
        secretNumber = _secretNumber; // Устанавливаем секретное число
    }
}

