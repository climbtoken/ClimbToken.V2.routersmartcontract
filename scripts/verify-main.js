require('dotenv').config();
const hre = require('hardhat');

const PANCAKE_FACTORY = '0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73';
const PANCAKE_ROUTER = '0x10ED43C718714eb63d5aA57B78B54704E256024E';
const WETH = '0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c';
const CLIMB_FEE_STRATEGY = '0xc2955aa91365423422EE640DaC2dBb63cb803956';
const CPANCAKE_ROUTER = '0xfb0b32BEE6a38825A56a7598Fff5379643211C21';

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
        PANCAKE_ROUTER,
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
