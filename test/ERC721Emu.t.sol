// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "forge-std/Test.sol";
import "../src/ERC721Emu.sol";

contract ERC721EmuT is Test {
    ERC721Emu public erc721emu;
    address owner = makeAddr("owner");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    function setUp() public {
        string memory name = "wellyercemu";
        string memory symbol = "WERCEMU";
        erc721emu = new ERC721Emu(name, symbol);
    }

    function testMintEnumerable() public {
        vm.startPrank(owner);
        for(uint i =0; i< 10;) {
            erc721emu.mint(i);
            unchecked {
                ++i;
            }
        }
        uint256 ownerCount = erc721emu.balanceOf(owner);
        vm.stopPrank();
        assertEq(ownerCount, 10);

    }

    function testApproveEnumerable() public {
        vm.startPrank(owner);
        erc721emu.mint(0);
        erc721emu.approve(user1, 0);
        vm.stopPrank();
        assertEq(erc721emu.getApproved(0), user1);
    }

    function testTransferEnumerable() public {
        vm.startPrank(owner);
        erc721emu.mint(0);
        erc721emu.safeTransferFrom(owner, user1, 0);
        vm.stopPrank();
        assertEq(erc721emu.ownerOf(0), user1);
    }

    function testSetApproveForAllEnumerable() public {
        vm.startPrank(owner);
        for(uint i =0; i< 10;) {
            erc721emu.mint(i);
            unchecked {
                ++i;
            }
        }
        erc721emu.setApprovalForAll(user1, true);
        assertEq(erc721emu.isApprovedForAll(owner,user1),true);
    }

    function testBurnEnumerable() public {
        vm.startPrank(owner);
        for(uint i =0; i< 10;) {
            erc721emu.mint(i);
            unchecked {
                ++i;
            }
        }
        for(uint i =0; i< 10;) {
            erc721emu.burn(i);
            unchecked {
                ++i;
            }
        }
        assertEq(erc721emu.balanceOf(owner),0);
        vm.stopPrank();
    }
}
