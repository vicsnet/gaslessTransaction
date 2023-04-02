import { ethers } from "hardhat";

async function main() {
	
  const TokenDeploy = await ethers.getContractFactory("VinceToken");

  
  const tokenDeploy = await TokenDeploy.deploy("0x69015912AA33720b842dCD6aC059Ed623F28d9f7");
await tokenDeploy.deployed();








}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });

  
// buyToken: 0xA771Ec96dFbcaa420426188060CceDdBC89f9b66

// swipeToken:  0x52b1d6589ab063F92964De60dB033787aE1A847b