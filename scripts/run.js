
const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'),
    });
    await waveContract.deployed();

    console.log("Contract deployed to:", waveContract.address);
    console.log("Contract deployed by:", owner.address);


    /*
     * Get Contract balance
     */
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );
    console.log(
        'Contract balance:',
        hre.ethers.utils.formatEther(contractBalance)
    );


    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    //invoke wave by creater address - 1st run
    let wave = await waveContract.wave('Hey!! all the best for your solidity learning');
    await wave.wait()

    waveCount = await waveContract.getTotalWaves();

    //invoke wave by creater address - 2nd run
    wave = await waveContract.wave('Test Wave');
    await wave.wait();

    //invoke the contract by different address
    wave = await waveContract.connect(randomPerson).wave('Welcome!! to web3.0 world');
    await wave.wait();

    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    }
    catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();