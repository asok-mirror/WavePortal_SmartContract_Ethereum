// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    //state variable
    uint256 totalWaves;
    mapping(address => uint256) public wavesTrackerByAddress;
    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    constructor() {
        console.log("I am an empty waveportal contract");
    }

    Wave[] waves;

    function wave(string calldata _message) external {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit NewWave(msg.sender, block.timestamp, _message);

        //track the wave count by address
        wavesTrackerByAddress[msg.sender] =
            getCurrentWaveCountBySender(msg.sender) +
            1;

        console.log(
            "%s has totally waved %s times",
            msg.sender,
            wavesTrackerByAddress[msg.sender]
        );
    }

    function getAllWaves() external view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("total number of people waved is: %s", totalWaves);
        return totalWaves;
    }

    function getCurrentWaveCountBySender(address sender)
        public
        view
        returns (uint256)
    {
        return wavesTrackerByAddress[sender];
    }
}
