// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {Test} from "forge-std/Test.sol";
import {Erc20} from "../src/Erc20.sol";
import {Evaluator} from "../src/Evaluator.sol";
import {IExerciceSolution} from "../src/IExerciceSolution.sol";

contract Erc20Test is Test {
    Erc20 public erc20;
    Evaluator public evaluator;

    function setUp() public {
        vm.createSelectFork(vm.envString("SEPOLIA_RPC_URL"));

        evaluator = Evaluator(payable(0x05A644d6d9BBd85861ff927245aaC13bd56e6d57));

        evaluator.ex0_setupProject();
        
        evaluator.ex1_getTickerAndSupply();
        string memory ticker = evaluator.assignedTicker(address(this));
        uint256 supply = evaluator.assignedSupply(address(this));

        erc20 = new Erc20(supply, ticker);

        evaluator.submitExercice(IExerciceSolution(address(erc20)));
    }

    function testEx2() public {
        evaluator.ex2_testErc20TickerAndSupply();
    }

    function testEx3() public {
        evaluator.ex2_testErc20TickerAndSupply();

        erc20.setCustomerWhiteListed(address(evaluator), true);

        evaluator.ex3_testGetToken();
    }

    function testEx4() public {
        evaluator.ex2_testErc20TickerAndSupply();

        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex4_testBuyToken();
    }

    function testEx5() public {
        evaluator.ex2_testErc20TickerAndSupply();
        erc20.setCustomerWhiteListed(address(evaluator), false);
        evaluator.ex5_testDenyListing();
    }

    function testEx6() public {
        evaluator.ex2_testErc20TickerAndSupply();
        evaluator.ex5_testDenyListing();

        erc20.setCustomerWhiteListed(address(evaluator), true);

        evaluator.ex6_testAllowListing();
    }

    function testEx7() public {
        evaluator.ex2_testErc20TickerAndSupply();
        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);

        evaluator.ex7_testDenyListing();
    }

    function testEx8() public {
        evaluator.ex2_testErc20TickerAndSupply();

        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);
        evaluator.ex7_testDenyListing();


        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex8_testTier1Listing();
    }

    function testEx9() public {
        evaluator.ex2_testErc20TickerAndSupply();

        erc20.setCustomerWhiteListed(address(evaluator), false);
        erc20.setCustomerTierLevel(address(evaluator), 0);
        evaluator.ex7_testDenyListing();

        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 1);
        evaluator.ex8_testTier1Listing();

        erc20.setCustomerWhiteListed(address(evaluator), true);
        erc20.setCustomerTierLevel(address(evaluator), 2);
        

        evaluator.ex9_testTier2Listing();
    }

}
