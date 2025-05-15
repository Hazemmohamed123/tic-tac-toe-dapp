require("@nomiclabs/hardhat-ethers")

module.exports = {
	  solidity: "0.8.18",
	  networks: {
		      sepolia: {
			            url: "https://sepolia.infura.io/v3/650640759cd9472eb6f818467d9600a3",
			            accounts: ["1a60b06b68ad6c0f6eef4b10d12f237b4f6af2e7beb53cd429c1205bc6e39cf6"]
			          }
		    }
};
