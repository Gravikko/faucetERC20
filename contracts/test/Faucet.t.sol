// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
 
import {Test} from "forge-std/Test.sol";
import {FaucetToken} from "../src/Faucet.sol";

contract FaucetTokenTest is Test {
    address public constant USER1 = address(0x1001);
    address public constant USER2 = address(0x1002);
    address public constant OWNER = address(0x1003);
    uint256 public constant DEFAULT_BALANCE = 100 ether;
    uint256 public constant DEFAULT_FAUCET_AMOUNT = 1;

    FaucetToken faucetToken;

    function setUp() public {
        vm.label(USER1, "user1");
        vm.label(USER2, "user2");

        vm.deal(USER1, DEFAULT_BALANCE);
        vm.deal(USER2, DEFAULT_BALANCE);

        faucetToken = new FaucetToken(OWNER);
        
    }

    function test_faucet() public {

        vm.warp(100);

        assertEq(faucetToken.balanceOf(USER1), 0);

        vm.prank(USER1);
        faucetToken.faucet(DEFAULT_FAUCET_AMOUNT);

        assertEq(faucetToken.balanceOf(USER1), DEFAULT_FAUCET_AMOUNT);
        assertEq(faucetToken.lastRequestedAt(USER1), 100);
    }

    function test_RevertWhen_InvalidAmount() public {
        uint256 invalidAmount = faucetToken.MAXIMUM_MINT_AMOUNT() + 1;

        vm.prank(USER1);
        vm.expectRevert(FaucetToken.InvalidAmount.selector);
        faucetToken.faucet(invalidAmount);
    }

    function test_RevertWhen_AddressUnderCoolDown() public {
        vm.warp(100);

        vm.prank(USER1);
        faucetToken.faucet(DEFAULT_FAUCET_AMOUNT);

        vm.prank(USER1);
        vm.expectRevert(FaucetToken.AddressUnderCoolDown.selector);
        faucetToken.faucet(DEFAULT_FAUCET_AMOUNT);
    }
}