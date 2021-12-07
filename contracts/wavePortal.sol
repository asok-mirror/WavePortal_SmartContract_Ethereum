// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    //state variable
    uint256 totalWaves;

    constructor() {
        console.log("I am an empty waveportal contract");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waves!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("total number of people waved is: %s", totalWaves);
        return totalWaves;
    }
}
