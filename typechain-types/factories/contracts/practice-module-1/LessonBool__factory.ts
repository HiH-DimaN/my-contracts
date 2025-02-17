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
  LessonBool,
  LessonBoolInterface,
} from "../../../contracts/practice-module-1/LessonBool";

const _abi = [
  {
    inputs: [],
    name: "ang",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "firstBool",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getBoolFour",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bool",
        name: "argBool",
        type: "bool",
      },
    ],
    name: "getBoolOne",
    outputs: [
      {
        internalType: "bool",
        name: "check",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bool",
        name: "argBool",
        type: "bool",
      },
    ],
    name: "getBoolThree",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bool",
        name: "argBool",
        type: "bool",
      },
    ],
    name: "getBoolTwo",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
] as const;

const _bytecode =
  "0x60806040525f805465ffffff00ff001916650100010001001790553480156024575f80fd5b506101c2806100325f395ff3fe608060405234801561000f575f80fd5b506004361061006e575f3560e01c8063b8daa9501161004d578063b8daa950146100b8578063f06ca14f146100cb578063f10a31a1146100d3575f80fd5b8062d77e8914610072578063169b32c3146100995780632298c16e146100a5575b5f80fd5b610085610080366004610166565b6100e6565b604051901515815260200160405180910390f35b5f546100859060ff1681565b5f54610085906301000000900460ff1681565b6100856100c6366004610166565b61010f565b610085610128565b6100856100e1366004610166565b610150565b5f8115155f60029054906101000a900460ff16151503610106575f610109565b60015b92915050565b5f805460ff16801561011e5750815b610106575f610109565b5f805460ff168061014157505f546301000000900460ff165b61014a57505f90565b50600190565b5f805460ff16151582151514610106575f610109565b5f60208284031215610176575f80fd5b81358015158114610185575f80fd5b939250505056fea26469706673582212209662d3dd113fb742f2b819eb365f2bb9ed6ae80318d50d4426cc992c9fd1eeac64736f6c634300081a0033";

type LessonBoolConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: LessonBoolConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class LessonBool__factory extends ContractFactory {
  constructor(...args: LessonBoolConstructorParams) {
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
      LessonBool & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): LessonBool__factory {
    return super.connect(runner) as LessonBool__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): LessonBoolInterface {
    return new Interface(_abi) as LessonBoolInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): LessonBool {
    return new Contract(address, _abi, runner) as unknown as LessonBool;
  }
}
