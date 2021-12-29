
// contracts/Box.sol
// SPDX-License-Identifier: MIT
// from: https://docs.openzeppelin.com/learn/developing-smart-contracts#setting-up-a-solidity-project
pragma solidity ^0.8.11;

contract Box {
  uint256 private value;

    // Emitted when the stored value changes
    event ValueChanged(uint256 newValue);

    // Stores a new value in the contract
    function store(uint256 newValue) public returns (uint256) {
        value = newValue;
        emit ValueChanged(newValue);
        return value;
    }

    // Reads the last stored value
    function retrieve() public view returns (uint256) {
        return value;
    }
}