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
import type { NonPayableOverrides } from "../../../../common";
import type {
  Array,
  ArrayInterface,
} from "../../../../contracts/practice-module-1/LessonArray1.sol/Array";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "arr",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "arr2",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "examples",
    outputs: [],
    stateMutability: "pure",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "i",
        type: "uint256",
      },
    ],
    name: "get",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getArr",
    outputs: [
      {
        internalType: "uint256[]",
        name: "",
        type: "uint256[]",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getLength",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "myFixedSizeArr",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "pop",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "i",
        type: "uint256",
      },
    ],
    name: "push",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "index",
        type: "uint256",
      },
    ],
    name: "remove",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x60e060405260016080818152600260a052600360c081905260209291906030565b50348015602b575f80fd5b50608b565b828054828255905f5260205f20908101928215606b579160200282015b82811115606b578251829060ff16905591602001919060010190604d565b5060759291506079565b5090565b5b808211156075575f8155600101607a565b6103c9806100985f395ff3fe608060405234801561000f575f80fd5b50600436106100b9575f3560e01c8063959ac48411610072578063be1c766b11610058578063be1c766b1461016d578063edf0099b14610174578063fb8cbced14610187575f80fd5b8063959ac48414610126578063a4ece52c14610165575f80fd5b80634cc82215116100a25780634cc82215146100ed57806371e5ee5f146101005780639507d39a14610113575f80fd5b8063335d00c2146100bd57806338a067ce146100c7575b5f80fd5b6100c561019c565b005b6100da6100d53660046102e0565b6101e1565b6040519081526020015b60405180910390f35b6100c56100fb3660046102e0565b6101f7565b6100da61010e3660046102e0565b610216565b6100da6101213660046102e0565b610234565b6100c56101343660046102e0565b5f80546001810182559080527f290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e5630155565b6100c5610257565b5f546100da565b6100da6101823660046102e0565b61027c565b61018f61028b565b6040516100e491906102f7565b60408051600580825260c082019092525f916020820160a0803683370190505090506001815f815181106101d2576101d2610339565b60200260200101818152505050565b600281600a81106101f0575f80fd5b0154905081565b5f818154811061020957610209610339565b5f91825260208220015550565b5f8181548110610224575f80fd5b5f91825260209091200154905081565b5f80828154811061024757610247610339565b905f5260205f2001549050919050565b5f80548061026757610267610366565b600190038181905f5260205f20015f90559055565b60018181548110610224575f80fd5b60605f8054806020026020016040519081016040528092919081815260200182805480156102d657602002820191905f5260205f20905b8154815260200190600101908083116102c2575b5050505050905090565b5f602082840312156102f0575f80fd5b5035919050565b602080825282518282018190525f918401906040840190835b8181101561032e578351835260209384019390920191600101610310565b509095945050505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603260045260245ffd5b7f4e487b71000000000000000000000000000000000000000000000000000000005f52603160045260245ffdfea2646970667358221220c9e2197ae289f41dfbdbd90db61111a0936d1262908e1f5b19073e5a9d8b6dfe64736f6c634300081a0033";

type ArrayConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ArrayConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Array__factory extends ContractFactory {
  constructor(...args: ArrayConstructorParams) {
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
      Array & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): Array__factory {
    return super.connect(runner) as Array__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ArrayInterface {
    return new Interface(_abi) as ArrayInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): Array {
    return new Contract(address, _abi, runner) as unknown as Array;
  }
}
