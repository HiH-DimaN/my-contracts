/* Voting contract with delegation/
 * Create a Solidity voting contract where you can delegate your votes to another participant. 
 */

  // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/* @title Контракт для голосования с делегированием
 * @author HiH_DimaN
 * @notice Позволяет участникам голосовать за предложения и делегировать свои голоса другим участникам.
 */
contract VotingWithDelegation {
    /* @notice Структура для хранения данных о предложении.
     */
    struct Proposal {
        string description; // Описание предложения.
        uint256 voteCount; // Количество голосов за предложение.
    }

    /* @notice Структура для хранения данных об участнике голосования.
     */
    struct Voter {
        uint256 weight; // Вес голоса участника (количество собственных голосов + делегированные голоса).
        bool voted; // Флаг, указывающий, проголосовал ли участник.
        uint256 delegate; // Адрес участника, которому делегированы голоса (0 - не делегировано).
        uint256 proposalVoted; // Индекс предложения, за которое проголосовал участник (0 - не голосовал).
    }

    /* @notice Массив для хранения всех предложений.
     */
    Proposal[] public proposals;

    /* @notice Маппинг для хранения данных об участниках голосования.
     * @dev Ключ - адрес участника, значение - структура Voter.
     */
    mapping(address => Voter) public voters;

    
}