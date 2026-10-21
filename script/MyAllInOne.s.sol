// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Erc20} from "../src/Erc20.sol";
import {Evaluator} from "../src/Evaluator.sol";
import {IExerciceSolution} from "../src/IExerciceSolution.sol";
import {IAllInOneSolution} from "../src/IAllInOneSolution.sol";
import {MyAllInOne} from "../src/MyAllInOne.sol";

contract MyAllInOneScript is Script {
    MyAllInOne public myallinone;
    Evaluator public evaluator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        evaluator = Evaluator(payable(0x05A644d6d9BBd85861ff927245aaC13bd56e6d57));
        myallinone = new MyAllInOne(evaluator);

        myallinone.startWorkshop();

        vm.stopBroadcast();
    }
}
