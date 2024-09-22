// Contract using structures.
// Write a contract that uses structures to store data.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/* @title Contract for storing data on goods in the store
 * @author HiH-DimaN
 * @notice This contract demonstrates the use of structures to store commodity data
 */

 contract ProductStore {
    struct Product {
        string name; // Product name
        uint256 price; // Price of goods
        uint256 quantity; // Quantity of goods in stock 
    }

    /* @notice Mapping for storing products by their IDs
     * @dev Key - product ID, value - Product structure
     */
    mapping(uint256 => Product) public products;

    /* @notice Counter for generating unique product IDs
     */
    uint256 public nextProductID = 1;

    /* @notice Event that is triggered when a new product is added
     * @param productId ID of the added product
     * @param name Name of the added product 
     */
    event ProductAdded(uint256 productID, string name);

    /* @notice Function for adding a new product
     * @param _name Product name
     * @param _price Price of the item
     * @param _quantity Quantity Quantity in stock
     */
    function addProduct(string memory _name, uint256 _price, uint256 _quantity) {
        products[nextProductID] = Product(_name, _price, _quantity);

        // Emit the event after adding a product
        emit ProductAdded(nextproductID, _name);

        nextProductID++;
 
    }

    /* @notice Function to retrieve product information
     * @param _productId Product ID
     * @return name Product name
     * @return price Price of the product
     * @return quantity Quantity in stock
     */
    function getProductInfo(uint256 _productID) public view returns(string memory name, uint256 price, uint256 quantity) {
        Product memory product = products[_productID];
        return (product.name, product.name, product.quantity);
    }





    
 }


