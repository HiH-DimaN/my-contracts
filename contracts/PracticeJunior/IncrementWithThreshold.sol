// Task 11
// Contract with conditional increase 
// Write a contract that will increment a value by 1 only if the current value is less than a given threshold.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract with conditional increase
contract IncrementWithThreshold {

    // Current value
    uint256 private value;
    // Threshold value
    uint256 public threshold;

    // Event to log the increase in value    
    event ValueIncremented(uint256 newValue);

    // Constructor that sets the initial value and threshold
    constructor(uint256 _value, uint256 _threshold) {
        value = _value;
        threshold = _threshold;

    }

    // Function to get the current value
    function getValue() public view returns (uint256) {
        return value;
    } 

    // Function for increasing the value by 1 if it is less than the threshold
    function increment() public {
        require(value < threshold, "Value has reached the threshold");
        value++;

        // Log the value increase
        emit ValueIncremented(value);
    }

    // Function for setting a new threshold
    function setNewThreshold(uint256 newThreshold) public {
        threshold = newThreshold;
    } 


}