// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    //state variable
    uint256 totalWaves;
    mapping(address => uint256) public wavesTrackerByAddress;

    constructor() {
        console.log("I am an empty waveportal contract");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved", msg.sender);

        //track the wave count by address
        wavesTrackerByAddress[msg.sender] = getCurrentWaveCountBySender(msg.sender) + 1;

        console.log("%s has totally waved %s times", msg.sender,  wavesTrackerByAddress[msg.sender]);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("total number of people waved is: %s", totalWaves);
        return totalWaves;
    }

    function getCurrentWaveCountBySender(address sender) private view returns (uint256) {
        return  wavesTrackerByAddress[sender];
    }
}
