import { deployments, ethers } from "hardhat";
import { expect } from "chai";
import { MyToken } from "../typechain-types";

describe("MyToken721", function () {
    beforeEach(async function () {
      // Загружаем фикстуру перед каждым тестом
      await deployments.fixture(["MyToken721"]); // Убедитесь, что "MyToken721" - это имя скрипта деплоя
      this.myToken = await ethers.getContract("MyToken721");
    });
  
    it("works", async function () {
      // Ваши тесты
      expect(await this.myToken.name()).to.equal("MyToken721");
    });
  });

/*describe("MyTokenERC721", function() {
    let token: MyToken;

    beforeEach(async function() { 
        await deployments.fixture(['MyTokenERC721']);
        demo = await ethers.getContract<MyToken>('MyTokenERC721');
    });

    it("works", async function () {
        console.log(token)
    })    
});
*/

    