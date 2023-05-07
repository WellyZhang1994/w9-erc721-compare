// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.6;

import "forge-std/Test.sol";
import "../src/ERC721a.sol";

contract ERC721aT is Test {
    ERC721a public erc721a;
    address owner = makeAddr("owner");
    address user1 = makeAddr("user1");
    address user2 = makeAddr("user2");

    function setUp() public {
        string memory name = "wellyerca";
        string memory symbol = "WERCA";
        vm.startPrank(owner);
        erc721a = new ERC721a(name, symbol);
        vm.stopPrank();
    }

    //mint 10 token for owner to observe the gas used
    function testMint721a() public {
        vm.startPrank(owner);
        erc721a.mint(10);
        uint256 ownerCount = erc721a.balanceOf(owner);
        vm.stopPrank();
        assertEq(ownerCount, 10);
    }

    //approve the token from owner to user1
    function testApprove721a() public {
        vm.startPrank(owner);
        erc721a.mint(1);
        uint256 ownerCount = erc721a.balanceOf(owner);

        erc721a.approve(user1, 0);
        vm.stopPrank();

        assertEq(ownerCount, 1);
        assertEq(erc721a.getApproved(0), user1);
    }

   //transfer the token from owner to user1 and check the balaceOf user1
    function testTransfer721a() public {
        vm.startPrank(owner);
        erc721a.mint(1);
        uint256 ownerCount = erc721a.balanceOf(owner);
        erc721a.safeTransferFrom(owner, user1, 0);
        assertEq(ownerCount, 1);
        assertEq(erc721a.ownerOf(0), user1);
        vm.stopPrank();
    }

    //setApproveAll for user1
    function testSetApproveForAll721a() public {
        vm.startPrank(owner);
        erc721a.mint(10);
        erc721a.setApprovalForAll(user1, true);
        assertEq(erc721a.isApprovedForAll(owner,user1),true);
        vm.stopPrank();
    }

    function testBurn721a() public {
        vm.startPrank(owner);
        erc721a.mint(10);
        for(uint i =0; i< 10;) {
            erc721a.burn(i);
            unchecked {
                ++i;
            }
        }
        assertEq(erc721a.balanceOf(owner),0);
        vm.stopPrank();
    }
}
