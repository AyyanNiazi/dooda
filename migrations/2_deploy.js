// migrations/2_deploy.js
// SPDX-License-Identifier: MIT
const Box = artifacts.require("Box");
const MyNft = artifacts.require("MyNft");

module.exports = function(deployer) {
  deployer.deploy(Box);
  deployer.deploy(MyNft);
};