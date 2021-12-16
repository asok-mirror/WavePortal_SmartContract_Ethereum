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

    uint256 private seed;

    constructor() payable {
        console.log("I am an empty waveportal contract");
        seed = (block.timestamp + block.difficulty) % 100;
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

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (seed <= 1) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.0000000001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Contract balance is low, so prize money cannot be withdrawn"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed tp withdraw money from contract.");
        }

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
