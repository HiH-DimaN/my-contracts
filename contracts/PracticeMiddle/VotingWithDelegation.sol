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

    /* @notice Событие, которое срабатывает при создании нового предложения.
     * @param proposalIndex Индекс созданного предложения.
     * @param description Описание предложения.
     */
    event ProposalCreated(uint256 proposalIndex, string description);

    /* @notice Событие, которое срабатывает при голосовании участника.
     * @param voter Адрес участника, который проголосовал.
     * @param proposalIndex Индекс предложения, за которое проголосовали.
     */
    event VoterCast(address voter, uint256 proposalIndex);

    /* @notice Событие, которое срабатывает при делегировании голосов.
     * @param delegator Адрес участника, который делегировал свои голоса.
     * @param delegate Адрес участника, которому были делегированы голоса.
     */
    event VoteDelegated(address delegator, address delegate);

    // --- Конструктор ---

    /* @notice Конструктор контракта. Создает начальные предложения.
     * @param _proposalDescriptions Массив описаний предложений.
     */
    constructor(string[] memory _proposalDescriptions) {
        // Цикл для создания начальных предложений на основе переданного массива
        for (uint256 i = 0; i <= _proposalDescriptions.length; i++) {
            // Создание новой структуры Proposal и добавление ее в массив proposals
            proposals.push(Proposal(_proposalDescriptions[i], 0));
            // Эмитирование события ProposalCreated для логирования создания предложения
            emit ProposalCreated(i, _proposalDescriptions[i]);
        }
    }

    // --- Функции ---

    /* @notice Функция для регистрации нового участника голосования.
     * @param _voterAddress Адрес участника.
     * @param _initialWeight Начальный вес голоса участника.
     */
    function registerVoter(address _voterAddress, uint256 _initialWeight) public {
        // Проверка, что участник еще не зарегистрирован
        require(voters[_voterAddress].weight == 0, "Voter already registered");
        
        // Установка начального веса голоса для нового участника
        voters[_voterAddress].weight = _initialWeight;
    }

    /* @notice Функция для делегирования голосов другому участнику.
     * @param _to Адрес участника, которому делегируются голоса.
     */
    function delegate(address _to) public {
        // Проверка, что нельзя делегировать голоса самому себе
        require(_to != msg.sender, "Cannot delegate to self");
        
        // Получение ссылки на структуру Voter для текущего участника (msg.sender)
        Voter storage sender = voters[msg.sender];

        // Проверка, что участник зарегистрирован (имеет ненулевой вес голоса)
        require(sender.weight > 0, "Voter not registered");
        // Проверка, что участник еще не голосовал
        require(sender.voted == false, "Voter already voted");

        



    }





    
}