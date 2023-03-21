// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract MyErc20 is ERC20,Ownable {

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_){}

    function mintTo(address account, uint256 amount) public onlyOwner returns (bool){
        require(account != address(0), 'can not mint to zero address');
        _mint(account, amount);
        return true;
    }

}