import { loadFixture, ethers, expect } from "./setup";

describe("Events", function() {
    async function deploy() {
        const [owner, other_addr] = await ethers.getSigners();

        const Factory = await ethers.getContractFactory("Events");
        const contract = await Factory.deploy();
        await contract.waitForDeployment();

        return { owner, other_addr, contract }
    }

    async function sendMoney(sender) {
        const amount = 100;
        const txData = {
            to: contract.address,
            value: amount
        }
        const tx = await sender.sendTransaction(txData)
        await tx.wait()
        return [tx, amount]
    }

    it("pay money receives money", async function() {
        const { owner, other_addr, contract } = await loadFixture(deploy);

        const tx = await contract.connect(owner).pay({ value: 100 });
        await tx.wait(1);

        await expect(tx).to.changeEtherBalance(owner, - 100)
    });

    it("withdraw owner success", async function() {
        const { owner, other_addr, contract } = await loadFixture(deploy);

        const tx = await contract.connect(owner).withdraw(other_addr);
        await tx.wait(1);

        await expect(tx).to.changeEtherBalances([contract, other_addr], [0,0])
    });

    it("withdraw non owner error", async function() {
        const { owner, other_addr, contract } = await loadFixture(deploy);

        const tx = await contract.connect(other_addr).withdraw(other_addr);
        await tx.wait(1);

        await expect(tx).to.changeEtherBalances([contract, other_addr], [0,0])
    });

});