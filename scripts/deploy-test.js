// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat');
require('dotenv').config();

const PANCAKE_FACTORY = '0x6725F303b657a9451d8BA641348b6761A6CC7a17';
const WETH = '0x2aab30a909748945d42c7d29d3cd44a5680cab1d';
const CLIMB_FEE_STRATEGY = '0x846713A36A6e9513018E8C768Bf7eF2169298f60';
const CPANCAKE_ROUTER = '0x288434905eDb58C9477cc50fdAe82Cb7C82eB8cd';

const deployClimbFeeStrategy = async () => {
  const ClimbFeeStrategy = await hre.ethers.getContractFactory('ClimbFeeStrategy');
  const climbFeeStrategy = await ClimbFeeStrategy.deploy();
  await climbFeeStrategy.deployed();

  console.log('[deployClimbFeeStrategy] climbFeeStrategy deployed to: ', climbFeeStrategy.address);
};

const deployCPancakeRouter = async () => {
  const CPancakeRouter = await hre.ethers.getContractFactory('CPancakeRouter');
  const cPancakeRouter = await CPancakeRouter.deploy(PANCAKE_FACTORY, WETH, CLIMB_FEE_STRATEGY);
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
