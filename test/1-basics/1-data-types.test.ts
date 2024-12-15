import { loadFixture, ethers, expect } from "../setup";

describe("DataTypes", function() {
    async function deploy() {
        const [user1, user2] = await ethers.getSigners();

        const Factory = await ethers.getContractFactory("DataTypes");
        const dataTypes = await Factory.deploy();
        await dataTypes.waitForDeployment();

        return { user1, user2, dataTypes }
    }

    it("should be deployed", async function() {
        const { user1, user2, dataTypes } = await loadFixture(deploy);
    
        console.log("# Contract address:", await dataTypes.getAddress())
        console.log("# user1 address:", user1.address)
        console.log("# user2 address:", user2.address)

        expect(dataTypes.target).to.be.properAddress;
    });


    it("should have 0 ethers by default", async function() {
        const { user1, user2, dataTypes } = await loadFixture(deploy);

        const balance = await ethers.provider.getBalance(dataTypes);
        expect(balance).to.eq(0);
    });

});