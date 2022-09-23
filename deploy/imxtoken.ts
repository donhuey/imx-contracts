import { ethers, hardhatArguments, run } from "hardhat";
import { getEnv, sleep } from "./utils";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying Contract with the account:", deployer.address);
  console.log("Account Balance:", (await deployer.getBalance()).toString());

  if (!hardhatArguments.network) {
    throw new Error("please pass --network");
  }

  const imxMinter = getEnv("IMX_TOKEN_MINTER");

  const IMXToken = await ethers.getContractFactory("IMXToken");
  const imxtoken = await IMXToken.deploy(imxMinter);
  console.log(`Deploying Contract Address: ${imxtoken.address}`);
  console.log("Verifying contract in 5 minutes...");
  await sleep(60000 * 5);
  await run("verify:verify", {
    address: imxtoken.address,
    constructorArguments: [imxMinter],
  });
}

main()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
