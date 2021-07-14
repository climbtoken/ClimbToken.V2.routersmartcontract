// SPDX-License-Identifier: MIT
pragma solidity >=0.6.6;

import './utils/SafeBEP20.sol';
import './utils/SafeMath.sol';
import './interfaces/IBEP20.sol';
import './interfaces/IPancakeFactory.sol';
import './interfaces/IPancakePair.sol';
import './interfaces/IPancakeRouter02.sol';
import './interfaces/IClimbFeeStrategy.sol';

contract CPancakeRouter {
    using SafeBEP20 for IBEP20;
    using SafeMath for uint256;

    address public pancakeFactory;
    address public pancakeRouter;
    address public WETH;
    address public climbStrategy;

    event Swape(uint indexed amount, address indexed to, bool indexed success);

    constructor (address _pancakeFactory, address _pancakeRouter, address _WETH, address _climbStrategy) public {
        pancakeFactory = _pancakeFactory;
        pancakeRouter = _pancakeRouter;
        WETH = _WETH;
        climbStrategy = _climbStrategy;
    }

    // function addLiquidity(
    //     address _tokenA,
    //     address _tokenB,
    //     uint _amountADesired,
    //     uint _amountBDesired,
    //     uint _amountAMin,
    //     uint _amountBMin,
    //     address _to,
    //     uint _deadline
    // ) external returns (uint amountA, uint amountB, uint liquidity) {
    //     address pair = _createPair(_tokenA, _tokenB);
    //     (amountA, amountB) = getExactAmounts(pair, _amountADesired, _amountBDesired, _amountAMin, _amountBMin);
    //     IBEP20(_tokenA).safeTransferFrom(msg.sender, address(this), amountA);
    //     IBEP20(_tokenB).safeTransferFrom(msg.sender, address(this), amountB);
    //     IBEP20(_tokenA).safeApprove(pancakeRouter, amountA);
    //     IBEP20(_tokenB).safeApprove(pancakeRouter, amountB);
    //     (amountA, amountB, liquidity) = IPancakeRouter02(pancakeRouter).addLiquidity(
    //         _tokenA,
    //         _tokenB,
    //         _amountADesired,
    //         _amountBDesired,
    //         _amountAMin,
    //         _amountBMin,
    //         _to,
    //         _deadline
    //     );
    // }

    // function addLiquidityETH(
    //     address _token,
    //     uint _amountTokenDesired,
    //     uint _amountTokenMin,
    //     uint _amountETHMin,
    //     address _to,
    //     uint _deadline
    // ) external payable returns (uint amountToken, uint amountETH, uint liquidity) {
    //     address pair = _createPair(_token, WETH);
    //     (amountToken, amountETH) = getExactAmounts(pair, _amountTokenDesired, msg.value, _amountTokenMin, _amountETHMin);
    //     IBEP20(_token).safeTransferFrom(msg.sender, address(this), amountToken);
    //     IBEP20(_token).safeApprove(pancakeRouter, amountToken);
    //     (amountToken, amountETH, liquidity) = IPancakeRouter02(pancakeRouter).addLiquidityETH{value: msg.value}(
    //         _token,
    //         _amountTokenDesired,
    //         _amountTokenMin,
    //         _amountETHMin,
    //         _to,
    //         _deadline
    //     );
    // }

    // function removeLiquidity(
    //     address _tokenA,
    //     address _tokenB,
    //     uint _liquidity,
    //     uint _amountAMin,
    //     uint _amountBMin,
    //     address _to,
    //     uint _deadline
    // ) public returns (uint amountA, uint amountB) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_tokenA, _tokenB);
    //     IBEP20(pair).safeTransferFrom(msg.sender, address(this), _liquidity);
    //     IBEP20(pair).safeApprove(pancakeRouter, _liquidity);
    //     (amountA, amountB) = IPancakeRouter02(pancakeRouter).removeLiquidity(
    //         _tokenA,
    //         _tokenB,
    //         _liquidity,
    //         _amountAMin,
    //         _amountBMin,
    //         _to,
    //         _deadline
    //     );
    // }

    // function removeLiquidityETH(
    //     address _token,
    //     uint _liquidity,
    //     uint _amountTokenMin,
    //     uint _amountETHMin,
    //     address _to,
    //     uint _deadline
    // ) public returns (uint amountToken, uint amountETH) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_token, WETH);
    //     IBEP20(pair).safeTransferFrom(msg.sender, address(this), _liquidity);
    //     IBEP20(pair).safeApprove(pancakeRouter, _liquidity);
    //     (amountToken, amountETH) = IPancakeRouter02(pancakeRouter).removeLiquidityETH(
    //         _token,
    //         _liquidity,
    //         _amountTokenMin,
    //         _amountETHMin,
    //         _to,
    //         _deadline
    //     );
    // }

    // function removeLiquidityWithPermit(
    //     address _tokenA,
    //     address _tokenB,
    //     uint _liquidity,
    //     uint _amountAMin,
    //     uint _amountBMin,
    //     address _to,
    //     uint _deadline,
    //     bool _approveMax, uint8 v, bytes32 r, bytes32 s
    // ) external returns (uint amountA, uint amountB) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_tokenA, _tokenB);
    //     uint value = _approveMax ? (2**256 - 1) : _liquidity;
    //     IPancakePair(pair).permit(msg.sender, address(this), value, _deadline, v, r, s);
    //     (amountA, amountB) = removeLiquidity(
    //         _tokenA,
    //         _tokenB,
    //         _liquidity,
    //         _amountAMin,
    //         _amountBMin,
    //         _to,
    //         _deadline
    //     );
    // }

    // function removeLiquidityETHWithPermit(
    //     address _token,
    //     uint _liquidity,
    //     uint _amountTokenMin,
    //     uint _amountETHMin,
    //     address _to,
    //     uint _deadline,
    //     bool _approveMax, uint8 v, bytes32 r, bytes32 s
    // ) external returns (uint amountA, uint amountB) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_token, WETH);
    //     uint value = _approveMax ? (2**256 - 1) : _liquidity;
    //     IPancakePair(pair).permit(msg.sender, address(this), value, _deadline, v, r, s);
    //     (amountA, amountB) = removeLiquidityETH(_token, _liquidity, _amountTokenMin, _amountETHMin, _to, _deadline);
    // }

    // function removeLiquidityETHSupportingFeeOnTransferTokens(
    //     address _token,
    //     uint _liquidity,
    //     uint _amountTokenMin,
    //     uint _amountETHMin,
    //     address _to,
    //     uint _deadline
    // ) public returns (uint amountETH) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_token, WETH);
    //     IBEP20(pair).safeTransferFrom(msg.sender, address(this), _liquidity);
    //     IBEP20(pair).safeApprove(pancakeRouter, _liquidity);
    //     amountETH = IPancakeRouter02(pancakeRouter).removeLiquidityETHSupportingFeeOnTransferTokens(
    //         _token,
    //         _liquidity,
    //         _amountTokenMin,
    //         _amountETHMin,
    //         _to,
    //         _deadline
    //     );
    // }
    // function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
    //     address _token,
    //     uint _liquidity,
    //     uint _amountTokenMin,
    //     uint _amountETHMin,
    //     address _to,
    //     uint _deadline,
    //     bool _approveMax, uint8 v, bytes32 r, bytes32 s
    // ) external returns (uint amountETH) {
    //     address pair = IPancakeFactory(pancakeFactory).getPair(_token, WETH);
    //     uint value = _approveMax ? (2**256 - 1) : _liquidity;
    //     IPancakePair(pair).permit(msg.sender, address(this), value, _deadline, v, r, s);
    //     amountETH = removeLiquidityETHSupportingFeeOnTransferTokens(
    //         _token,
    //         _liquidity,
    //         _amountTokenMin,
    //         _amountETHMin,
    //         _to,
    //         _deadline
    //     );
    // }

    function swapExactTokensForTokens(
        uint _amountIn,
        uint _amountOutMin,
        address[] calldata _path,
        address _to,
        uint _deadline
    ) external returns (uint[] memory amounts) {
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(_amountIn, _path[0]);
        amounts = IPancakeRouter02(pancakeRouter).getAmountsOut(_amountIn.sub(feeAmount), _path);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), _amountIn);
        IBEP20(_path[0]).approve(pancakeRouter, _amountIn);
        amounts = IPancakeRouter02(pancakeRouter).swapExactTokensForTokens(
            _amountIn.sub(feeAmount),
            _amountOutMin.sub(_amountOutMin.mul(IClimbFeeStrategy(climbStrategy).slippageForNativeTokens()).div(10000)),
            _path,
            _to,
            _deadline
        );
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapExactTokensForETH(uint _amountIn, uint _amountOutMin, address[] calldata _path, address _to, uint _deadline)
        external
        returns (uint[] memory amounts)
    {
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(_amountIn, _path[0]);
        amounts = IPancakeRouter02(pancakeRouter).getAmountsOut(_amountIn.sub(feeAmount), _path);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), _amountIn);
        IBEP20(_path[0]).approve(pancakeRouter, _amountIn);
        amounts = IPancakeRouter02(pancakeRouter).swapExactTokensForETH(
            _amountIn.sub(feeAmount),
            _amountOutMin.sub(_amountOutMin.mul(IClimbFeeStrategy(climbStrategy).slippageForNativeTokens()).div(10000)),
            _path,
            _to,
            _deadline
        );
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapETHForExactTokens(uint _amountOut, address[] calldata _path, address _to, uint _deadline)
        external
        payable
        returns (uint[] memory amounts)
    {
        amounts = IPancakeRouter02(pancakeRouter).swapETHForExactTokens{value: msg.value}(_amountOut, _path, _to, _deadline);
        if (msg.value > amounts[0]) {
            payable(msg.sender).transfer(msg.value - amounts[0]);
        }
        // (bool success, bytes memory result) = pancakeRouter.delegatecall(abi.encodeWithSignature("swapETHForExactTokens(uint,address[],address,uint)",
        //     _amountOut,
        //     _path,
        //     _to,
        //     _deadline
        // ));

        // emit Swape(_amountOut, _to, success);
        // amounts = abi.decode(result, (uint[]));
    }

    function swapTokensForExactTokens(
        uint _amountOut,
        uint _amountInMax,
        address[] calldata _path,
        address _to,
        uint _deadline
    ) external returns (uint[] memory amounts) {
        amounts = IPancakeRouter02(pancakeRouter).getAmountsIn(_amountOut, _path);
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(amounts[0], _path[0]);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), amounts[0]);
        IBEP20(_path[0]).approve(pancakeRouter, amounts[0]);
        amounts[0] = amounts[0].sub(feeAmount);
        uint[] memory amountsOut = IPancakeRouter02(pancakeRouter).getAmountsOut(amounts[0], _path);
        amounts = IPancakeRouter02(pancakeRouter).swapTokensForExactTokens(amountsOut[amountsOut.length - 1], _amountInMax, _path, _to, _deadline);
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapTokensForExactETH(uint _amountOut, uint _amountInMax, address[] calldata _path, address _to, uint _deadline)
        external
        returns (uint[] memory amounts)
    {
        amounts = IPancakeRouter02(pancakeRouter).getAmountsIn(_amountOut, _path);
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(amounts[0], _path[0]);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), amounts[0]);
        IBEP20(_path[0]).approve(pancakeRouter, amounts[0]);
        amounts[0] = amounts[0].sub(feeAmount);
        uint[] memory amountsOut = IPancakeRouter02(pancakeRouter).getAmountsOut(amounts[0], _path);
        amounts = IPancakeRouter02(pancakeRouter).swapTokensForExactETH(amountsOut[amountsOut.length - 1], _amountInMax, _path, _to, _deadline);
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapExactETHForTokens(uint _amountOutMin, address[] calldata _path, address _to, uint _deadline)
        external
        payable
        returns (uint[] memory amounts)
    {
        amounts = IPancakeRouter02(pancakeRouter).swapExactETHForTokens{value: msg.value}(_amountOutMin, _path, _to, _deadline);
    }

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint _amountIn,
        uint _amountOutMin,
        address[] calldata _path,
        address _to,
        uint _deadline
    ) external {
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(_amountIn, _path[0]);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), _amountIn);
        IBEP20(_path[0]).approve(pancakeRouter, _amountIn);
        IPancakeRouter02(pancakeRouter).swapExactTokensForTokensSupportingFeeOnTransferTokens(
            _amountIn.sub(feeAmount),
            _amountOutMin.sub(_amountOutMin.mul(IClimbFeeStrategy(climbStrategy).slippageForNativeTokens()).div(10000)),
            _path,
            _to,
            _deadline
        );
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint _amountIn,
        uint _amountOutMin,
        address[] calldata _path,
        address _to,
        uint _deadline
    )
        external
    {
        uint feeAmount = IClimbFeeStrategy(climbStrategy).calculateFeeForNativeTokens(_amountIn, _path[0]);
        IBEP20(_path[0]).safeTransferFrom(msg.sender, address(this), _amountIn);
        IBEP20(_path[0]).approve(pancakeRouter, _amountIn);
        IPancakeRouter02(pancakeRouter).swapExactTokensForETHSupportingFeeOnTransferTokens(
            _amountIn.sub(feeAmount),
            _amountOutMin.sub(_amountOutMin.mul(IClimbFeeStrategy(climbStrategy).slippageForNativeTokens()).div(10000)),
            _path,
            _to,
            _deadline
        );
        if (feeAmount > 0) {
            IBEP20(_path[0]).safeTransfer(IClimbFeeStrategy(climbStrategy).feeAddress(), feeAmount);
        }
    }

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint _amountOutMin,
        address[] calldata _path,
        address _to,
        uint _deadline
    )
        external
        payable
    {
        
        (bool success, ) = pancakeRouter.call{value: msg.value}(abi.encodeWithSignature("swapExactETHForTokensSupportingFeeOnTransferTokens{(uint,address[],address,uint)",
            _amountOutMin,
            _path,
            _to,
            _deadline
        ));

        emit Swape(_amountOutMin, _to, success);
    }

    function getExactAmounts(address _pair, uint _amountADesired, uint _amountBDesired, uint _amountAMin, uint _amountBMin) public view returns (uint amountA, uint amountB) {
        (uint reserve0, uint reserve1,) = IPancakePair(_pair).getReserves();
        if (reserve0 == 0 && reserve1 == 0) {
            (amountA, amountB) = (_amountADesired, _amountBDesired);
        } else {
            uint amountBOptimal = _quote(_amountADesired, reserve0, reserve1);
            if (amountBOptimal <= _amountBDesired) {
                require(amountBOptimal >= _amountBMin);
                (amountA, amountB) = (_amountADesired, amountBOptimal);
            } else {
                uint amountAOptimal = _quote(_amountBDesired, reserve1, reserve0);
                assert(amountAOptimal <= _amountADesired);
                require(amountAOptimal >= _amountAMin);
                (amountA, amountB) = (amountAOptimal, _amountBDesired);
            }
        }
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function _quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0);
        require(reserveA > 0 && reserveB > 0);
        amountB = amountA.mul(reserveB) / reserveA;
    }

    function _createPair(address _tokenA, address _tokenB) internal returns (address pair) {
        pair = IPancakeFactory(pancakeFactory).getPair(_tokenA, _tokenB);
        if (pair == address(0)) {
            pair = IPancakeFactory(pancakeFactory).createPair(_tokenA, _tokenB);
        }
    }
}
