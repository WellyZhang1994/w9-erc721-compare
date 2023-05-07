// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;
import "ERC721A/ERC721A.sol";

contract ERC721a is ERC721A {
    constructor(string memory _name,string memory _symbol) 
        ERC721A(_name,_symbol)
    {}

    function mint(uint256 quantity) external payable {
        // `_mint`'s second argument now takes in a `quantity`, not a `tokenId`.
        _mint(msg.sender, quantity);
    }

    function burn(uint256 tokenId) external {
        _burn(tokenId);
    }
}