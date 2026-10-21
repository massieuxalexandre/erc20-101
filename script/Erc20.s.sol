// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Erc20} from "../src/Erc20.sol";
import {Evaluator} from "../src/Evaluator.sol";
import {IExerciceSolution} from "../src/IExerciceSolution.sol";

contract Erc20Script is Script {
    Erc20 public erc20;
    Evaluator public evaluator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        evaluator = Evaluator(payable(0x05A644d6d9BBd85861ff927245aaC13bd56e6d57));

        evaluator.ex0_setupProject();

        evaluator.ex1_getTickerAndSupply();
        string memory ticker = evaluator.assignedTicker(msg.sender);
        uint256 supply = evaluator.assignedSupply(msg.sender);

        erc20 = new Erc20(supply, ticker);

        evaluator.submitExercice(IExerciceSolution(address(erc20)));

        evaluator.ex2_testErc20TickerAndSupply();
    

    
        erc20.setCustomerWhiteListed(address(evaluator), true);
        evaluator.ex3_testGetToken();
    


        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex4_testBuyToken();



        erc20.setCustomerWhiteListed(address(evaluator), false);
        evaluator.ex5_testDenyListing();
    


        evaluator.ex5_testDenyListing();

        erc20.setCustomerWhiteListed(address(evaluator), true);

        evaluator.ex6_testAllowListing();
    


        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);

        evaluator.ex7_testDenyListing();
    


        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);
        evaluator.ex7_testDenyListing();


        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex8_testTier1Listing();
    


        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);
        evaluator.ex7_testDenyListing();

        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex8_testTier1Listing();

        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 2);
        

        evaluator.ex9_testTier2Listing();
    


        vm.stopBroadcast();
    }
}
