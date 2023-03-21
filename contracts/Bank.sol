// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';

contract Bank is Ownable{
    mapping(address => uint256) funds;


    function save () external payable returns (bool) {
        uint256 amount = funds[msg.sender];
        amount += msg.value;
        funds[msg.sender] = amount;
        return true;
    }

    function check(address user) view external onlyOwner returns (uint256){
        return funds[user];
    }

    function withdrawal(uint256 amount) external returns (bool){
        uint256 current = funds[msg.sender];
        require(current >= amount, 'balance not enough');
        (bool success, )= msg.sender.call{value: amount}("");
        if (success) {
            funds[msg.sender] = current - amount;
            return true;
        }else {
            return false;
        }
    }

    
}
