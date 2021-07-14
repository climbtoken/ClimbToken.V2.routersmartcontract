// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import '@uniswap/lib/contracts/libraries/TransferHelper.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

import './utils/SafeMath.sol';

contract ClimbFeeStrategy is Ownable {
    using SafeMath for uint;

    address public MNTN = 0xA7Fcb2BAaBDA9dB593e24B25A1a32bfb5168018b;
    address public CLIMB = 0x2A1d286ed5edAD78BeFD6E0d8BEb38791e8cD69d;
    address public MARS = 0xF1A71bcCe29b598d812a30BaedFf860a7Dce0aff;

    address public feeAddress = 0xD01A3bA68E7acdD8A5EBaB68d6d6CfA313fec272;
    uint256 public slippageForNativeTokens = 1000;

    function isNativeToken(address input) public view returns (bool) {
      if (input == MNTN || input == CLIMB || input == MARS) {
          return true;
      }
      return false;
    }

    function calculateFeeForNativeTokens(uint _amountIn, address _token) public view returns (uint) {
        uint feeAmount = 0;
        if (isNativeToken(_token)) {
            feeAmount = _amountIn.mul(slippageForNativeTokens).div(10000);
        }
        return feeAmount;
    }

    function setFeeAddress(address _feeAddress) public {
        require(msg.sender == _feeAddress);
        feeAddress = _feeAddress;
    }

    function setSlippageFornativeTokens(uint256 _slippageForNativeTokens) public onlyOwner {
        require(_slippageForNativeTokens <= 10000);
        slippageForNativeTokens = _slippageForNativeTokens;
    }
}
