// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {MyAllInOne} from "../src/MyAllInOne.sol";
import {Evaluator} from "../src/Evaluator.sol";
import {IExerciceSolution} from "../src/IExerciceSolution.sol";
import {IAllInOneSolution} from "../src/IAllInOneSolution.sol";

contract MyAllInOneTest is Test {
    MyAllInOne public myallinone;
    Evaluator public evaluator;

    function setUp() public {
        vm.createSelectFork(vm.envString("SEPOLIA_RPC_URL"));

        evaluator = Evaluator(payable(0x05A644d6d9BBd85861ff927245aaC13bd56e6d57));
        myallinone = new MyAllInOne(evaluator);
       
    }

    function testEx10() public {
        myallinone.startWorkshop();
    }
}