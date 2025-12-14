// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
 
import {Script, console} from "forge-std/Script.sol";
import {FaucetToken} from "../src/Faucet.sol";

contract DeployFaucet is Script {
    function run() public returns (address faucetTokenAddress) {
        uint256 deployerPrivateKey = vm.envUnit("PRIVATE_KEY");

        address initialOwner = vm.addr(deployerPrivateKey);

        vm.startBroadcast();

        console.log("Deploying FaucetToken");
        console.log("Owner will be set to : ", initialOwner);
        
        FaucetToken faucetToken = new FaucetToken(initialOwner);

        vm.stopBroadcast();

        faucetTokenAddress = address(faucetToken);
        console.log("✅ FaucetToken deployed to:", faucetTokenAddress);
    }
}