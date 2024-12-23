/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import {
  Contract,
  ContractFactory,
  ContractTransactionResponse,
  Interface,
} from "ethers";
import type {
  Signer,
  AddressLike,
  ContractDeployTransaction,
  ContractRunner,
} from "ethers";
import type { NonPayableOverrides } from "../../../../common";
import type {
  ContractOne,
  ContractOneInterface,
} from "../../../../contracts/practice-module-1/LessonDlegateCallAdditionally.sol/ContractOne";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "_contractThree",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "bool",
        name: "success",
        type: "bool",
      },
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "DelegatecallResult",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "bytes",
        name: "data",
        type: "bytes",
      },
    ],
    name: "FallbackCalled",
    type: "event",
  },
  {
    stateMutability: "payable",
    type: "fallback",
  },
  {
    inputs: [],
    name: "contractThree",
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
    name: "result",
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
    stateMutability: "payable",
    type: "receive",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b50604051610365380380610365833981016040819052602b91604e565b5f80546001600160a01b0319166001600160a01b03929092169190911790556079565b5f60208284031215605d575f80fd5b81516001600160a01b03811681146072575f80fd5b9392505050565b6102df806100865f395ff3fe60806040526004361061002c575f3560e01c8063653721471461019f578063d9252e2b146101c757610033565b3661003357005b7f17c1956f6e992470102c5fc953bf560fda31fabee8737cf8e77bdde00eb5698d5f36604051610064929190610217565b60405180910390a15f8054604051829173ffffffffffffffffffffffffffffffffffffffff16906100989083903690610245565b5f60405180830381855af49150503d805f81146100d0576040519150601f19603f3d011682016040523d82523d5f602084013e6100d5565b606091505b509150915081610145576040517f08c379a000000000000000000000000000000000000000000000000000000000815260206004820152601360248201527f44656c656761746563616c6c206661696c656400000000000000000000000000604482015260640160405180910390fd5b7f4cd051a5ac1ab7a32d07ce8d8f7ca631ec39b268bd6a57ebd6ef71bfe9ca1db28282604051610176929190610254565b60405180910390a180511561019d57808060200190518101906101999190610292565b6001555b005b3480156101aa575f80fd5b506101b460015481565b6040519081526020015b60405180910390f35b3480156101d2575f80fd5b505f546101f29073ffffffffffffffffffffffffffffffffffffffff1681565b60405173ffffffffffffffffffffffffffffffffffffffff90911681526020016101be565b60208152816020820152818360408301375f818301604090810191909152601f909201601f19160101919050565b818382375f9101908152919050565b8215158152604060208201525f82518060408401528060208501606085015e5f606082850101526060601f19601f8301168401019150509392505050565b5f602082840312156102a2575f80fd5b505191905056fea2646970667358221220b80ef58fd9954bd8b4537d854fb84130c30b145e030c6cec146afab34440d49164736f6c634300081a0033";

type ContractOneConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: ContractOneConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class ContractOne__factory extends ContractFactory {
  constructor(...args: ContractOneConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    _contractThree: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(_contractThree, overrides || {});
  }
  override deploy(
    _contractThree: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ) {
    return super.deploy(_contractThree, overrides || {}) as Promise<
      ContractOne & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): ContractOne__factory {
    return super.connect(runner) as ContractOne__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): ContractOneInterface {
    return new Interface(_abi) as ContractOneInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): ContractOne {
    return new Contract(address, _abi, runner) as unknown as ContractOne;
  }
}
