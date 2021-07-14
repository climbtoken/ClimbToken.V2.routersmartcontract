require('dotenv').config();
const hre = require('hardhat');

const PANCAKE_FACTORY = '0x6725F303b657a9451d8BA641348b6761A6CC7a17';
const WETH = '0x2aab30a909748945d42c7d29d3cd44a5680cab1d';
const CLIMB_FEE_STRATEGY = '0x846713A36A6e9513018E8C768Bf7eF2169298f60';
const CPANCAKE_ROUTER = '0x288434905eDb58C9477cc50fdAe82Cb7C82eB8cd';

const climbFeeStrategyVerify = async () => {
  if (CLIMB_FEE_STRATEGY) {
    await hre.run('verify:verify', {
      address: CLIMB_FEE_STRATEGY
    })
  }
};

const cPancakeRouterVerify = async () => {
  if (CPANCAKE_ROUTER) {
    await hre.run('verify:verify', {
      address: CPANCAKE_ROUTER,
      constructorArguments: [
        PANCAKE_FACTORY,
        WETH,
        CLIMB_FEE_STRATEGY
      ]
    })
  }
}

const main = async () => {
  // await climbFeeStrategyVerify();
  await cPancakeRouterVerify();
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
