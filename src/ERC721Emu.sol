// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;
import "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract ERC721Emu is ERC721Enumerable {
    constructor(string memory _name,string memory _symbol) 
    ERC721(_name,_symbol)
    {}

    function mint(uint256 tokenId) external {
        _safeMint(msg.sender, tokenId);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }
}