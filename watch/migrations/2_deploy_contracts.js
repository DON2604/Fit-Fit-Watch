const FitnessApp = artifacts.require("FitnessApp");

module.exports = function(deployer) {
  deployer.deploy(FitnessApp);
}