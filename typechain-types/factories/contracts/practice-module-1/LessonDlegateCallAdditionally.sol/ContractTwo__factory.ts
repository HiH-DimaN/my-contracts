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
  ContractTwo,
  ContractTwoInterface,
} from "../../../../contracts/practice-module-1/LessonDlegateCallAdditionally.sol/ContractTwo";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "contractOneAddress",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "a",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "b",
        type: "uint256",
      },
    ],
    name: "callContractOne",
    outputs: [
      {
        internalType: "bytes",
        name: "",
        type: "bytes",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b506102788061001c5f395ff3fe608060405234801561000f575f80fd5b5060043610610029575f3560e01c8063696aa3421461002d575b5f80fd5b61004061003b3660046101ad565b610056565b60405161004d91906101f7565b60405180910390f35b60405160248101839052604481018290526060905f9060640160408051601f198184030181529181526020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff167f9abadad500000000000000000000000000000000000000000000000000000000179052519091505f90819073ffffffffffffffffffffffffffffffffffffffff88169082906100f490869061022c565b5f6040518083038185875af1925050503d805f811461012e576040519150601f19603f3d011682016040523d82523d5f602084013e610133565b606091505b5091509150816101a3576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601a60248201527f43616c6c20746f20436f6e74726163744f6e65206661696c6564000000000000604482015260640160405180910390fd5b9695505050505050565b5f805f606084860312156101bf575f80fd5b833573ffffffffffffffffffffffffffffffffffffffff811681146101e2575f80fd5b95602085013595506040909401359392505050565b602081525f82518060208401528060208501604085015e5f604082850101526040601f19601f83011684010191505092915050565b5f82518060208501845e5f92019182525091905056fea26469706673582212204128f6341ecf217a075593c74bc72e7ff0235f9dc312ffb60f2f436745672a4c64736f6c634300081a0033";

type ContractTwoConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ContractTwoConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ContractTwo__factory extends ContractFactory {
  constructor(...args: ContractTwoConstructorParams) {
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
      ContractTwo & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): ContractTwo__factory {
    return super.connect(runner) as ContractTwo__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ContractTwoInterface {
    return new Interface(_abi) as ContractTwoInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): ContractTwo {
    return new Contract(address, _abi, runner) as unknown as ContractTwo;
  }
}
