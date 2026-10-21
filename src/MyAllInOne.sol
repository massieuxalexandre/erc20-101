// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IAllInOneSolution} from "./IAllInOneSolution.sol";
import {Erc20} from "./Erc20.sol";
import {Evaluator} from "./Evaluator.sol";
import {IExerciceSolution} from "./IExerciceSolution.sol";

contract MyAllInOne is IAllInOneSolution {
    Erc20 public erc20;
    Evaluator public evaluator;

    constructor(Evaluator _evaluator) {
        evaluator = _evaluator;
    }

    function startWorkshop() external {
        evaluator.ex10_allInOne();
    }

    function completeWorkshop() external override {
        evaluator.ex0_setupProject();

        evaluator.ex1_getTickerAndSupply();
        string memory ticker = evaluator.assignedTicker(address(this));
        uint256 supply = evaluator.assignedSupply(address(this));

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
    

        erc20.setCustomerWhiteListed(address(evaluator), true);
        evaluator.ex6_testAllowListing();
    

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
