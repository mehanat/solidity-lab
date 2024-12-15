import { loadFixture, ethers, expect } from "../setup";

describe("Fallback", function() {
    async function deploy() {
        const [owner, other_addr] = await ethers.getSigners();

        const Factory = await ethers.getContractFactory("Fallback");
        const contract = await Factory.deploy();
        await contract.waitForDeployment();

        return { owner, other_addr, contract }
    }

    it("become an owner", async function() {
        const { owner, other_addr, contract } = await loadFixture(deploy);
    
        // Check initial owner
        expect(await contract.owner()).to.equal(owner.address);

        // Call contribute function
        await contract.connect(other_addr).contribute({ value: ethers.parseEther('0.0001') })
        // Send some eth to the contract
        await other_addr.sendTransaction({ to: await contract.getAddress(), value: ethers.parseEther('0.0001') })


        // Check new owner
        expect(await contract.owner()).to.equal(other_addr.address);
    });

});