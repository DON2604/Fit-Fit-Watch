module.exports = {
  networks: {
    development: {
      host: "192.168.1.182",
      port: 7545,
      network_id: "*", // Match any network id
    },
    
  },
  contracts_directory: "./contracts",
  
  compilers: {
    solc: {
      version: "0.8.13",
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  db: {
    enabled: false
  }

};