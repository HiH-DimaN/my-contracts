import { string } from "hardhat/internal/core/params/argumentTypes";
import { loadFixture, ethers, expect } from "./setup";

describe("MusicShop", function() {
    async function deploy() {
        const [owner, buyer] = await ethers.getSigners();

        const MusicShop = await ethers.getContractFactory("MusicShop");
        const shop = await MusicShop.deploy(owner.address);
        await shop.waitForDeployment();

        return { shop, owner, buyer };

    }

    it("should aloow to add albums", async function () {
        const { shop } = await loadFixture(deploy);

        const title = "Demo";
        const price = 100;
        const uid = ethers.solidityPackedKeccak256([string], [title]);
        const qty = 5;
        const initialIndex = 0;

        const addTx = await shop.addAlbum(uid, title, price, qty);
        await addTx.wait();

        const album = await shop.albums(initialIndex);

        expect(album.index).to.eq(initialIndex);
        expect(album.uid).to.eq(uid);
        expect(album.title).to.eq(title);
        expect(album.price).to.eq(price);
        expect(album.quantity).to.eq(qty);

        expect(await shop.currentIndex()).to.eq(initialIndex + 1);
    });

    it("should aloow to add albums", async function () {
        const { shop, buyer } = await loadFixture(deploy);

        const title = "Demo";
        const price = 100;
        const uid = ethers.solidityPackedKeccak256([string], [title]);
        const qty = 5;
        const albumIdxToBuy = 0;
        const initialOrdeId = 0;

        expect(await shop.currentOrderId()).to.eq(initialOrdeId);

        const addTx = await shop.addAlbum(uid, title, price, qty);
        await addTx.wait();

        const album = await shop.albums(albumIdxToBuy);

        const buyTx = await shop;
            .connect(buyer);
            .buy(albumIdxToBuy, { value: price });
        const receipt = await buyTx.wait();

        await expect(buyTx).to.changeEtherBalance([shop, buyer], [price, -price]);

        expect(receipt).not.to.be.undefined;
        const block = await ethers.provider.getBlock(receipt!.blockNumber)
    });    


});