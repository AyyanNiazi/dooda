// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Techroad is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    uint256 public PRICE;
    address public myAddress = msg.sender;    
    uint256 public val = msg.value;    

    // Map the number of tokens per bunnyId
    mapping(uint8 => uint256) public techroadCount;

    // Map the number of tokens burnt per techroadId
    mapping(uint8 => uint256) public techroadBurnCount;

    // Used for generating the tokenId of new NFT minted
    Counters.Counter private _tokenIds;

    // Map the techroadId for each tokenId
    mapping(uint256 => uint8) private techroadIds;

    // Map the techroadName for a tokenId
    mapping(uint8 => string) private techroadNames;

    // test
    mapping(uint8 => uint8) public test;

    constructor() ERC721("Techroad", "Tech") {
        // 0.1 BNB
        PRICE = 100000000000000000;
    }

    function tranferNft(address from, address to, uint256 _tokenId) external payable returns(uint256) {
        // require(num < 10, "number is greater than 10");

        // payable(to).transfer(PRICE);
        safeTransferFrom(from, to, _tokenId);
        return _tokenId;
    }

    function _baseURI() internal pure override returns (string memory) {
        return 'https://gateway.pinata.cloud/ipfs/QmNpBgQmFCZAyoCQq5gkF8DfHGfpWPpAnqbcRuhZRbccua/';
    }
    

   
    /**
     * @dev Get techroad for a specific tokenId.
     */
    function getTechroadId(uint256 _tokenId) external view returns (uint8) {
        return techroadIds[_tokenId];
    }

    /**
     * @dev Get the associated techroadName for a specific techroadId.
     */
    function getTechroadName(uint8 _techroadId)
        external
        view
        returns (string memory)
    {
        return techroadNames[_techroadId];
    }

    /**
     * @dev Get the associated techroadName for a unique tokenId.
     */
    function getTechroadNameOfTokenId(uint256 _tokenId)
        external
        view
        returns (string memory)
    {
        uint8 techroadId = techroadIds[_tokenId];
        return techroadNames[techroadId];
    }

      /**
     * @dev Gets current Price
     */
    function getNFTPrice() public view returns (uint256) {
        require(12 < 1000, "Sale has already ended");
        return PRICE;
    }

    /**
     * @dev Mint NFTs. Only the owner can call it.
     */
    function mint(
        address _to,
        string calldata _tokenURI,
        uint8 _techroadId
    ) public payable returns (uint256) {
        // require(getNFTPrice() == msg.value, "BNB value sent is not correct");
        uint256 newId = _tokenIds.current();
        _tokenIds.increment();
        techroadIds[newId] = _techroadId;
        techroadCount[_techroadId] = techroadCount[_techroadId].add(1);
        _mint(_to, newId);
        _setTokenURI(newId, _tokenURI);
        return newId;
    }

        /**
        * @dev Set a unique name for each techroadId. It is supposed to be called once.
        */
        function setTechroadName(uint8 _techroadId, string calldata _name)
            external
            onlyOwner
        {
            techroadNames[_techroadId] = _name;
        }

        function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
            super._burn(tokenId);
        }

        /**
        * @dev Burn a NFT token. Callable by owner only.
        */
        function burn(uint256 _tokenId) external onlyOwner {
            uint8 techroadIdBurnt = techroadIds[_tokenId];
            techroadCount[techroadIdBurnt] = techroadCount[techroadIdBurnt].sub(1);
            techroadBurnCount[techroadIdBurnt] = techroadBurnCount[techroadIdBurnt].add(1);
            _burn(_tokenId);
        }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
}
