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
  FeedbackContract,
  FeedbackContractInterface,
} from "../../../contracts/practice-junior/FeedbackContract";

const _abi = [
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "address",
        name: "user",
        type: "address",
      },
      {
        indexed: false,
        internalType: "string",
        name: "message",
        type: "string",
      },
      {
        indexed: false,
        internalType: "bool",
        name: "success",
        type: "bool",
      },
    ],
    name: "FeedbackGenerated",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_input",
        type: "string",
      },
    ],
    name: "perfomAction",
    outputs: [
      {
        internalType: "bool",
        name: "",
        type: "bool",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b506101ef8061001c5f395ff3fe608060405234801561000f575f80fd5b5060043610610029575f3560e01c8063cfbd4e561461002d575b5f80fd5b61004061003b366004610105565b610054565b604051901515815260200160405180910390f35b80515f90819015610063575060015b604080513381526060602082018190526019908201527f416374696f6e20686173206265656e20706572666f726d65640000000000000060808201528215158183015290517fba5ed9b44d417522673288f1542f96d8ecb9477cd4c2d046a05c05f39447301f9181900360a00190a192915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b5f60208284031215610115575f80fd5b813567ffffffffffffffff81111561012b575f80fd5b8201601f8101841361013b575f80fd5b803567ffffffffffffffff811115610155576101556100d8565b604051601f19603f601f19601f8501160116810181811067ffffffffffffffff82111715610185576101856100d8565b60405281815282820160200186101561019c575f80fd5b816020840160208301375f9181016020019190915294935050505056fea26469706673582212208b218abd21a70bc36aaa94ad836384c58b586e1963b4ed4e6acb12efcbf4c64964736f6c634300081a0033";

type FeedbackContractConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: FeedbackContractConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class FeedbackContract__factory extends ContractFactory {
  constructor(...args: FeedbackContractConstructorParams) {
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
      FeedbackContract & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): FeedbackContract__factory {
    return super.connect(runner) as FeedbackContract__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): FeedbackContractInterface {
    return new Interface(_abi) as FeedbackContractInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): FeedbackContract {
    return new Contract(address, _abi, runner) as unknown as FeedbackContract;
  }
}
