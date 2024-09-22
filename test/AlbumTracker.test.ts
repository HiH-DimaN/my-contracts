import { expect, loadFixture } from "./setup";
import { AlbumTracker, Album_factory } from "../typechain-types";
import { BaseContract, ContractTransactionReceipt } from "ethers";

export { loadFixture, ethers, expect } from "./setup";

describe("AlbumTracker", function() {
    async function deploy() {
        const [ owner, buyer ] = await ethers.getSigners();

        const AlbumTracker = await ethers.getContractFactory("AlbumTracker");

        const tracker = await AlbumTracker.deploy();

        await tracker.waitForDeployment();

        return { tracker, owner, buyer };

    }

    it("deploys albums", async function () {
        const { tracker, buyer } = await loadFixture(deploy);

        const albumTitle = "Enchantment of the Ring";
        const albumPrice = ethers.parseEther("0.00005");

        await createAlbum(tracker, albumTitle, albumPrice);

        const expectedAlbumAddr = await precomputeAddress(tracker);

        const album = Album_factory.connect(expectedAlbumAddr, buyer);

        expect(await album.price()).to.eq(albumPrice);
        
    });

    it("creates albums", async function () {
        loadFixture(deploy);
        
    });

    async function precomputeAddress(sc: BaseContract, nonce = 1): Promise<string> {
        return ethers.getCreateAddress({
            from: await sc.getAddress(),
            nonce

        })

        
    }

    async function createAlbum(tracker: AlbumTracker, title: string, price: bigint): Promise<ContractTransactionReceipt | null> {
        const createAlbumTx = await tracker.createAlbum(price, title);
        
        return await createAlbumTx.wait()
    }
    
});