// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

interface IClimbFeeStrategy {
  function isNativeToken(address _input) external view returns (bool);
  function calculateFeeForNativeTokens(uint _amountIn, address _token) external view returns (uint);
  function setFeeAddress(address _feeAddress) external;
  function feeAddress() external returns (address);
  function slippageForNativeTokens() external returns (uint);
}
