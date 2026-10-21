// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Erc20} from "../src/Erc20.sol";

contract Erc20Script is Script {
    Erc20 public erc20;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        erc20 = new Erc20(533983428000000000000000000, "giw4o5i");

        vm.stopBroadcast();
    }
}
