var Regulator = artifacts.require("./Regulator.sol");

module.exports = function(deployer) {
//   deployer.deploy(ConvertLib);
//   deployer.link(ConvertLib, MetaCoin);
  deployer.deploy(Regulator);
};
