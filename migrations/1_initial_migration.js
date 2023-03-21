var Migrations = artifacts.require("./Migrations.sol");
var Bank = artifacts.require("./Bank.sol")

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Bank);
};
