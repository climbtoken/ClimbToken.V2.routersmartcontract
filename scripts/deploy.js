// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat');
require('dotenv').config();

const PANCAKE_FACTORY = '0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73';
const PANCAKE_ROUTER = '0x10ED43C718714eb63d5aA57B78B54704E256024E';
const WETH = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c';
const CLIMB_FEE_STRATEGY = '0xc2955aa91365423422EE640DaC2dBb63cb803956';
const CPANCAKE_ROUTER = '0xfb0b32BEE6a38825A56a7598Fff5379643211C21';

const deployClimbFeeStrategy = async () => {
  const ClimbFeeStrategy = await hre.ethers.getContractFactory('ClimbFeeStrategy');
  const climbFeeStrategy = await ClimbFeeStrategy.deploy();
  await climbFeeStrategy.deployed();

  console.log('[deployClimbFeeStrategy] climbFeeStrategy deployed to: ', climbFeeStrategy.address);
};

const deployCPancakeRouter = async () => {
  const CPancakeRouter = await hre.ethers.getContractFactory('CPancakeRouter');
  const cPancakeRouter = await CPancakeRouter.deploy(PANCAKE_FACTORY, PANCAKE_ROUTER, WETH, CLIMB_FEE_STRATEGY);
  await cPancakeRouter.deployed();

  console.log('[deployCPancakeRouter] cPancakeRouter deployed to: ', cPancakeRouter.address);
};

async function main() {
  // await deployClimbFeeStrategy();
  await deployCPancakeRouter();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
