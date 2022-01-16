// migrations/2_deploy.js
// SPDX-License-Identifier: MIT
const Techroad = artifacts.require("Techroad");

module.exports = function(deployer) {
  deployer.deploy(Techroad);
};