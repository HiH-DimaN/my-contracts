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
import type { NonPayableOverrides } from "../../../../../common";
import type {
  Honeypot,
  HoneypotInterface,
} from "../../../../../contracts/practice-GuideDAO/security/BankHoneypot.sol/Honeypot";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "initiator",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "eventCode",
        type: "uint256",
      },
    ],
    name: "log",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b506101228061001c5f395ff3fe6080604052348015600e575f80fd5b50600436106026575f3560e01c80638309e8a814602a575b5f80fd5b6039603536600460ac565b603b565b005b8060020360a8576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152600c60248201527f686f6e6579706f74746564210000000000000000000000000000000000000000604482015260640160405180910390fd5b5050565b5f806040838503121560bc575f80fd5b823573ffffffffffffffffffffffffffffffffffffffff8116811460de575f80fd5b94602093909301359350505056fea26469706673582212208f0b4c6ba59b8e31b624a4cd595760295d0cc748e6275b2a5c9154d6b64c8f5d64736f6c634300081a0033";

type HoneypotConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: HoneypotConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class Honeypot__factory extends ContractFactory {
  constructor(...args: HoneypotConstructorParams) {
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
      Honeypot & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): Honeypot__factory {
    return super.connect(runner) as Honeypot__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): HoneypotInterface {
    return new Interface(_abi) as HoneypotInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): Honeypot {
    return new Contract(address, _abi, runner) as unknown as Honeypot;
  }
}
