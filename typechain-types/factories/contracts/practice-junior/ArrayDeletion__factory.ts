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
  ArrayDeletion,
  ArrayDeletionInterface,
} from "../../../contracts/practice-junior/ArrayDeletion";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "index",
        type: "uint256",
      },
    ],
    name: "addNumber",
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
    name: "getNumber",
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
    name: "numbers",
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
        name: "index",
        type: "uint256",
      },
    ],
    name: "removeNumber",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b506103318061001c5f395ff3fe608060405234801561000f575f80fd5b506004361061004a575f3560e01c8063d39fa2331461004e578063eea54fb614610073578063fc56365814610088578063fce680231461009b575b5f80fd5b61006161005c36600461027c565b6100da565b60405190815260200160405180910390f35b61008661008136600461027c565b6100f8565b005b61006161009636600461027c565b6101ef565b6100866100a936600461027c565b5f80546001810182559080527f290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e5630155565b5f81815481106100e8575f80fd5b5f91825260209091200154905081565b5f548110610167576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601360248201527f496e646578206f7574206f6620626f756e64730000000000000000000000000060448201526064015b60405180910390fd5b805b5f54610177906001906102a7565b8110156101c8575f61018a8260016102c0565b8154811061019a5761019a6102d3565b905f5260205f2001545f82815481106101b5576101b56102d3565b5f91825260209091200155600101610169565b505f8054806101d9576101d96102e7565b600190038181905f5260205f20015f9055905550565b5f8054821061025a576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601360248201527f496e646578206f7574206f6620626f756e647300000000000000000000000000604482015260640161015e565b5f828154811061026c5761026c6102d3565b905f5260205f2001549050919050565b5f6020828403121561028c575f80fd5b5035919050565b634e487b7160e01b5f52601160045260245ffd5b818103818111156102ba576102ba610293565b92915050565b808201808211156102ba576102ba610293565b634e487b7160e01b5f52603260045260245ffd5b634e487b7160e01b5f52603160045260245ffdfea2646970667358221220924bee42833229654c0758511cd0f46dde559ea51744251548b4a59042e6494864736f6c634300081a0033";

type ArrayDeletionConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ArrayDeletionConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ArrayDeletion__factory extends ContractFactory {
  constructor(...args: ArrayDeletionConstructorParams) {
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
      ArrayDeletion & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): ArrayDeletion__factory {
    return super.connect(runner) as ArrayDeletion__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ArrayDeletionInterface {
    return new Interface(_abi) as ArrayDeletionInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): ArrayDeletion {
    return new Contract(address, _abi, runner) as unknown as ArrayDeletion;
  }
}
