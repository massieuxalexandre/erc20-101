// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Erc20 is ERC20 {
    mapping (address => bool) private whiteListedCustomers;
    mapping (address => uint256) private tierLevelCustomers;

    constructor(uint256 initialSupply, string memory ticker)  ERC20("ERC20 Exercise Token", ticker) {
        _mint(msg.sender, initialSupply);
    }

    function getToken() external returns (bool) {
        require(whiteListedCustomers[msg.sender], "You are not whitelisted");
        _mint(msg.sender, 1 ether);
        return true;
    }

    function buyToken() external payable returns (bool) {
        require(msg.value > 0, "You need to send some ether");
        require(whiteListedCustomers[msg.sender], "You are not whitelisted");
        require(tierLevelCustomers[msg.sender] > 0, "You are not in a valid tier");
        uint256 amount = msg.value * 1000 * tierLevelCustomers[msg.sender];
        _mint(msg.sender, amount);
        return true;
    }

    function setCustomerWhiteListed(address customerAddress, bool allowed) external {
        whiteListedCustomers[customerAddress] = allowed;
    }
    
    function isCustomerWhiteListed(address customerAddress) external returns (bool) {
        return whiteListedCustomers[customerAddress];
    }

    function setCustomerTierLevel(address customerAddress, uint256 tier) external {
        tierLevelCustomers[customerAddress] = tier;
    }
    

    function customerTierLevel(address customerAddress) external returns (uint256) {
        return tierLevelCustomers[customerAddress];
    }
}
