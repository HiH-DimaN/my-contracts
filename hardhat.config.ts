import { HardhatUserConfig } from "hardhat/types";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";
import "@typechain/hardhat";

const config: HardhatUserConfig = {
  solidity: "0.8.13",
  typechain: {
    outDir: "typechain-types",
    target: "ethers-v5",
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};

export default config;
