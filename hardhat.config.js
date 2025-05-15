require('@nomiclabs/hardhat-waffle');

module.exports = {
  solidity: '0.8.0',
  networks: {
    goerli: {
      url: 'https://mainnet.infura.io/v3/650640759cd9472eb6f818467d9600a3',
      accounts: [0xAFA7cC7947A0d5d883c3A50DF547185158d23A39]
    }
  }
};
