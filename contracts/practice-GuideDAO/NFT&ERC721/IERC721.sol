// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @title Интерфейс ERC721
 * @dev Стандарт для неконцентрируемых токенов (NFT), который определяет основные функции для управления токенами.
 * Интерфейс описывает основные операции с токенами, такие как передача, утверждение и получение информации о владельце.
 */
interface IERC721 {

    /** 
     * @dev Событие для передачи токена.
     * @param from Адрес отправителя (старый владелец).
     * @param to Адрес получателя (новый владелец).
     * @param tokenId Идентификатор токена, который был передан.
     */
    event Transfer(address indexed from, address indexed to, uint indexed tokenId); // Событие передачи токена

    /** 
     * @dev Событие для утверждения адреса, которому разрешено управлять токеном.
     * @param owner Адрес владельца токена.
     * @param approved Адрес утвержденного адреса для управления токеном.
     * @param tokenId Идентификатор токена, для которого предоставлено разрешение.
     */
    event Approval(address indexed owner, address indexed approved, uint indexed tokenId); // Событие утверждения токена

    /** 
     * @dev Событие для предоставления или отмены разрешения для оператора управлять всеми токенами владельца.
     * @param owner Адрес владельца токенов.
     * @param operator Адрес оператора, которому предоставлено/отменено разрешение.
     * @param approved Статус утверждения: `true` если оператор имеет доступ, `false` если нет.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved); // Событие утверждения оператора

    /** 
     * @dev Функция для получения количества токенов, принадлежащих адресу.
     * @param owner Адрес владельца токенов.
     * @return Количество токенов, принадлежащих указанному адресу.
     */
    function balanceOf(address owner) external view returns(uint); // Получить баланс токенов у владельца

    /** 
     * @dev Функция для получения владельца токена по его идентификатору.
     * @param tokenId Идентификатор токена.
     * @return Адрес владельца токена.
     */
    function ownerOf(uint tokenId) external view returns(address); // Получить владельца токена

    /** 
     * @dev Функция для безопасной передачи токена с дополнительными данными.
     * @param from Адрес отправителя (старый владелец).
     * @param to Адрес получателя (новый владелец).
     * @param tokenId Идентификатор токена.
     * @param data Дополнительные данные для передачи (например, для взаимодействия с другими контрактами).
     */
    function safeTransferFrom(
        address from,
        address to,
        uint tokenId,
        bytes calldata data
    ) external; // Безопасная передача токена с дополнительными данными

    /** 
     * @dev Функция для передачи токена от одного адреса к другому.
     * @param from Адрес отправителя (старый владелец).
     * @param to Адрес получателя (новый владелец).
     * @param tokenId Идентификатор токена.
     */
    function transferFrom(
        address from,
        address to,
        uint tokenId
    ) external; // Передача токена

    /** 
     * @dev Функция для утверждения адреса для управления конкретным токеном.
     * @param to Адрес, которому разрешается управлять токеном.
     * @param tokenId Идентификатор токена.
     */
    function approve(
        address to,
        uint tokenId
    ) external; // Утверждение адреса для управления токеном

    /** 
     * @dev Функция для утверждения или отмены разрешения для оператора управлять всеми токенами владельца.
     * @param operator Адрес оператора, которому предоставляется разрешение или отменяется.
     * @param approved Статус утверждения: `true` для предоставления разрешения, `false` для отмены.
     */
    function setApprovalForAll(
        address operator,
        bool approved
    ) external; // Утверждение оператора для всех токенов владельца

    /** 
     * @dev Функция для получения адреса, который был утвержден для управления токеном.
     * @param tokenId Идентификатор токена.
     * @return Адрес, который был утвержден для управления токеном.
     */
    function getApproved(
        uint tokenId
    ) external view returns(address); // Получить адрес, утвержденный для управления токеном

    /** 
     * @dev Функция для проверки, имеет ли оператор разрешение управлять всеми токенами владельца.
     * @param owner Адрес владельца токенов.
     * @param operator Адрес оператора, чье разрешение проверяется.
     * @return Возвращает `true`, если оператор имеет разрешение управлять всеми токенами владельца, `false` если нет.
     */
    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns(bool); // Проверка разрешения оператора управлять всеми токенами владельца
}
