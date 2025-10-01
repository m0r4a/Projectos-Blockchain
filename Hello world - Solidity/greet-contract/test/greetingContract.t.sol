pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {GreetingContract} from "../src/greetingContract.sol";

contract GreetingContractTest is Test {
    GreetingContract public greeting;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        owner = address(this);
        user1 = address(0x1);
        user2 = address(0x2);

        greeting = new GreetingContract();
    }

    function testOwnerIsSet() public view {
        assertEq(greeting.owner(), owner);
    }

    function testStoreName() public {
        greeting.storeName("Alice");
        assertEq(greeting.getName(address(this)), "Alice");
    }

    function testStoreNameEmitsEvent() public {
        vm.expectEmit(true, false, false, true);
        emit GreetingContract.NameStored(address(this), "Bob");
        greeting.storeName("Bob");
    }

    function testCannotStoreEmptyName() public {
        vm.expectRevert("Name cannot be empty");
        greeting.storeName("");
    }

    function testGreetMe() public {
        greeting.storeName("Charlie");
        string memory result = greeting.greetMe();
        assertEq(result, "Hola, Charlie!");
    }

    function testGreetMeRevertsWithoutName() public {
        vm.expectRevert("Name not stored");
        greeting.greetMe();
    }

    function testGreetAddress() public {
        vm.prank(user1);
        greeting.storeName("David");

        string memory result = greeting.greetAddress(user1);
        assertEq(result, "Hola, David!");
    }

    function testGreetAddressRevertsIfNoName() public {
        vm.expectRevert("User has no name stored");
        greeting.greetAddress(user1);
    }

    function testGetName() public {
        vm.prank(user1);
        greeting.storeName("Eve");

        assertEq(greeting.getName(user1), "Eve");
    }

    function testGetNameReturnsEmptyForUnsetAddress() public view {
        assertEq(greeting.getName(user2), "");
    }

    function testDeleteMyName() public {
        greeting.storeName("Frank");
        assertEq(greeting.getName(address(this)), "Frank");

        greeting.deleteMyName();
        assertEq(greeting.getName(address(this)), "");
    }

    function testDeleteMyNameRevertsWithoutName() public {
        vm.expectRevert("Name not stored");
        greeting.deleteMyName();
    }

    function testEmergencyResetAsOwner() public {
        vm.prank(user1);
        greeting.storeName("Grace");

        assertEq(greeting.getName(user1), "Grace");

        greeting.emergencyReset(user1);
        assertEq(greeting.getName(user1), "");
    }

    function testEmergencyResetRevertsIfNotOwner() public {
        greeting.storeName("Henry");

        vm.prank(user1);
        vm.expectRevert("Only owner can call this function");
        greeting.emergencyReset(address(this));
    }

    function testUpdateName() public {
        greeting.storeName("Isabel");
        assertEq(greeting.getName(address(this)), "Isabel");

        greeting.storeName("Isabella");
        assertEq(greeting.getName(address(this)), "Isabella");
    }

    function testMultipleUsersCanStoreDifferentNames() public {
        greeting.storeName("Jack");

        vm.prank(user1);
        greeting.storeName("Jill");

        vm.prank(user2);
        greeting.storeName("John");

        assertEq(greeting.getName(address(this)), "Jack");
        assertEq(greeting.getName(user1), "Jill");
        assertEq(greeting.getName(user2), "John");
    }
}
