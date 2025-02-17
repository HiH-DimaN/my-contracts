/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type { Signer, ContractDeployTransaction, ContractRunner } from "ethers";
import type { NonPayableOverrides } from "../../../common";
import type {
  Lesson,
  LessonInterface,
} from "../../../contracts/practice-module-1/Lesson";

const _abi = [
  {
    inputs: [],
    name: "myAddr",
    outputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "smeil",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "text",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

const _bytecode =
  "0x5f80546001600160a01b031916735b38da6a701c568545dcfcb03fcb875f56beddc417905560c0604052600c60809081526b48656c6c6f20776f726c642160a01b60a0526002906100509082610123565b50604080518082019091526004815263f09f988360e01b60208201526003906100799082610123565b50348015610085575f80fd5b506101dd565b634e487b7160e01b5f52604160045260245ffd5b600181811c908216806100b357607f821691505b6020821081036100d157634e487b7160e01b5f52602260045260245ffd5b50919050565b601f82111561011e57805f5260205f20601f840160051c810160208510156100fc5750805b601f840160051c820191505b8181101561011b575f8155600101610108565b50505b505050565b81516001600160401b0381111561013c5761013c61008b565b6101508161014a845461009f565b846100d7565b6020601f821160018114610182575f831561016b5750848201515b5f19600385901b1c1916600184901b17845561011b565b5f84815260208120601f198516915b828110156101b15787850151825560209485019460019092019101610191565b50848210156101ce57868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b610220806101ea5f395ff3fe608060405234801561000f575f80fd5b506004361061003f575f3560e01c80631f1bd692146100435780637fa7208214610061578063e665b26614610069575b5f80fd5b61004b6100ad565b6040516100589190610146565b60405180910390f35b61004b610139565b5f546100889073ffffffffffffffffffffffffffffffffffffffff1681565b60405173ffffffffffffffffffffffffffffffffffffffff9091168152602001610058565b600280546100ba90610199565b80601f01602080910402602001604051908101604052809291908181526020018280546100e690610199565b80156101315780601f1061010857610100808354040283529160200191610131565b820191905f5260205f20905b81548152906001019060200180831161011457829003601f168201915b505050505081565b600380546100ba90610199565b602081525f82518060208401528060208501604085015e5f6040828501015260407fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f83011684010191505092915050565b600181811c908216806101ad57607f821691505b6020821081036101e4577f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5091905056fea26469706673582212204c7e7e03eb6bff6a03478ceed1e015f4070394c9bb0445550c9d2389cc4a7aa264736f6c634300081a0033";

type LessonConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: LessonConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Lesson__factory extends ContractFactory {
  constructor(...args: LessonConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(overrides || {});
  }
  override deploy(overrides?: NonPayableOverrides & { from?: string }) {
    return super.deploy(overrides || {}) as Promise<
      Lesson & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): Lesson__factory {
    return super.connect(runner) as Lesson__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): LessonInterface {
    return new Interface(_abi) as LessonInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): Lesson {
    return new Contract(address, _abi, runner) as unknown as Lesson;
  }
}
