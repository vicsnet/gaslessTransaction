import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.18",
  networks:{
    sepolia:{
      url:"https://eth-sepolia.g.alchemy.com/v2/K3WQD6pWbUy8xzRs3s8OVYppcMyoCWjE",
    // @ts-ignore
      accounts:[ "a495703354cff429858008a639852747da03d8a59e6822a846a635325848f489"],
    },
    
  }
  ,
  // etherscan:{
  //   apiKey: process.env.API_KEY,
  // }
};

export default config;
