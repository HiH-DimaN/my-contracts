// Contract to interact with another contract.
// Create a contract that interacts with another contract to retrieve data.

// Contract that interacts with a DataProvider (DataConsumer.sol)

// SPDX-License--Identifier: MIT
pragma solidity ^0.8.0;

// Interface for interaction with the contract DataProvider
/*interface IDataProvider {
    function getData() external view returns(uint256);
}*/

contract DataConsumer {
    /*// Variable for storing a reference to the contract DataProvider
    IDataProvider public dataProvider;

    // Constructor for setting the contract address DataProvider
    constructor (address _dataProviderAddress) {
        dataProvider = IDataProvider(_dataProviderAddress);

    }

    // Function for getting data from the contract DataProvider
    function fetchData() external view returns(uint256) {
        return dataProvider.getData();
    }

    // Function for changing the contract address DataProvider
    function setDataProvider(address _dataProviderAddress) external {
        dataProvider = IDataProvider(_dataProviderAddress);
    }*/

    // Interaction with DataProvider via call
    function fetchData(address dataProviderAddress) external view returns (uint256) {
        // Defining the signature of the getData() function for call
        (bool success, bytes memory data) = dataProviderAddress.staticcall(
            abi.encodeWithSignature("getData()")
        );
        require(success, "Call failed");

        // Decoding the return value
        return abi.decode(data, (uint256));
    }

    // Example of settingData function call via call
    function setData(address dataProviderAddress, uint256 _newData) external {
        // Defining the signature of the function setData(uint256) for call
        (bool success, ) = dataProviderAddress.call(
            abi.encodeWithSignature("setData(uint256)", _newData)
        );
        require(success, "Call failed");
    }

}