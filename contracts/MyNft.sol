// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNft is ERC1155, Ownable {
    uint256 public constant GOLD = 0;

    constructor() ERC1155("https://gateway.pinata.cloud/ipfs/QmcNai9baG6RYgCuAFx52pyf1qT4Kgm3SwYXwdL1cy3xYk") {
        _mint(msg.sender, GOLD, 1, "");

    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

}