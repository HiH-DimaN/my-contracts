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
  KeyExistence,
  KeyExistenceInterface,
} from "../../../contracts/practice-junior/KeyExistence";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_address",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "_balance",
        type: "uint256",
      },
    ],
    name: "addBalance",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    name: "balances",
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
        internalType: "address",
        name: "_address",
        type: "address",
      },
    ],
    name: "exists",
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
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    name: "keyExists",
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
  "0x6080604052348015600e575f80fd5b506101fe8061001c5f395ff3fe608060405234801561000f575f80fd5b506004361061004a575f3560e01c806321e5383a1461004e57806327e235e3146100bc578063cd413329146100ee578063f6a3d24e14610120575b5f80fd5b6100ba61005c366004610180565b73ffffffffffffffffffffffffffffffffffffffff9091165f908152602081815260408083209390935560019081905291902080547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00169091179055565b005b6100db6100ca3660046101a8565b5f6020819052908152604090205481565b6040519081526020015b60405180910390f35b6101106100fc3660046101a8565b60016020525f908152604090205460ff1681565b60405190151581526020016100e5565b61011061012e3660046101a8565b73ffffffffffffffffffffffffffffffffffffffff165f9081526001602052604090205460ff1690565b803573ffffffffffffffffffffffffffffffffffffffff8116811461017b575f80fd5b919050565b5f8060408385031215610191575f80fd5b61019a83610158565b946020939093013593505050565b5f602082840312156101b8575f80fd5b6101c182610158565b939250505056fea26469706673582212202ea458097dfa2f194c9bc15075122f4475171ceb40dc736f6de1d45e4ad8f3d264736f6c634300081a0033";

type KeyExistenceConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: KeyExistenceConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class KeyExistence__factory extends ContractFactory {
  constructor(...args: KeyExistenceConstructorParams) {
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
      KeyExistence & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): KeyExistence__factory {
    return super.connect(runner) as KeyExistence__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): KeyExistenceInterface {
    return new Interface(_abi) as KeyExistenceInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): KeyExistence {
    return new Contract(address, _abi, runner) as unknown as KeyExistence;
  }
}
