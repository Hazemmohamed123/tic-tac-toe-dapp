const hre = require("hardhat");

async function main() {
  const TicTacToe = await hre.ethers.getContractFactory("TicTacToe");
  const game = await TicTacToe.deploy();
  await game.deployed();
  console.log("TicTacToe deployed to:", game.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});