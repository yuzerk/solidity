// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import '@openzeppelin/contracts/utils/math/Math.sol';
import '@openzeppelin/contracts/utils/math/SafeMath.sol';

contract Univ2Protocal is Ownable{

    uint256 private aAmount;

    uint256 private bAmount;

    address private coinA;

    address private coinB;

    function setCoinPair(address _a, address _b) external onlyOwner{
        coinA = _a;
        coinB = _b;
    }

    function queryPair() external view returns (address, address){
        return (coinA, coinB);
    }

    function addLiquidity(uint256 _aAmount, uint256 _bAmount) external onlyOwner returns (uint256, uint256) {
        // 把授权过的A 币种    转到当前合约内
        IERC20(coinA).transferFrom(msg.sender, address(this), _aAmount);
        // 把授权过的B 币种    转到当前合约内
        IERC20(coinB).transferFrom(msg.sender, address(this), _bAmount);

        (bool successA, uint256 resA) = SafeMath.tryAdd(aAmount, _aAmount);
        (bool successB, uint256 resB) = SafeMath.tryAdd(bAmount, _bAmount);
        require(successA && successB, "add fail , by SafeMath.tryAdd");
        aAmount = resA;
        bAmount = resB;
        return (aAmount, bAmount);
    }

    function swap(address _tokenIn, uint256 _amountIn, uint256 _amountOutMin, address _to) external {
        require(_tokenIn != address(0), "tokenIn can not be zero address");
        require(_to != address(0), "_to can not be zero address");
        require(_tokenIn == coinA || _tokenIn == coinB, "tokenIn must be A or B that has be set");

        //coin A to coin B
        if (_tokenIn == coinA) {

            // 把授权过的A 币种    转到当前合约内
            IERC20(coinA).transferFrom(msg.sender, address(this), _amountIn);

            (bool success, uint res) = SafeMath.tryAdd(aAmount, _amountIn);
            require(success, "tokenIn amount add fail, source from safeMath");
            aAmount = res;

            uint256 swapAmount = Math.mulDiv(_amountIn, bAmount, aAmount);
            require(swapAmount > _amountOutMin, "amountOut less than _amountOutMin");
            require(swapAmount < bAmount, "tokenOut amount not enough");
            bAmount -= swapAmount;

            // 把兑换出的币种 B发到指定的 _to 去
            IERC20(coinB).transfer(_to, swapAmount);
        //coin A to coin B
        }else if (_tokenIn == coinB) {

            // 把授权过的B 币种    转到当前合约内
            IERC20(coinA).transferFrom(msg.sender, address(this), _amountIn);

            (bool success, uint res) = SafeMath.tryAdd(bAmount, _amountIn);
            require(success, "tokenIn amount add fail, source from safeMath");
            bAmount = res;

            uint256 swapAmount = Math.mulDiv(_amountIn, aAmount, bAmount);
            require(swapAmount > _amountOutMin, "amountOut less than _amountOutMin");
            require(swapAmount < aAmount, "tokenOut amount not enough");
            aAmount -= swapAmount;

            // 把兑换出的币种 B发到指定的 _to 去
            IERC20(coinA).transfer(_to, swapAmount);
        }
    }

    function _checkInit() internal view {
        require(coinA != address(0), "coinA has not be set");
        require(coinB != address(0), "coinB has not be set");
    }

}