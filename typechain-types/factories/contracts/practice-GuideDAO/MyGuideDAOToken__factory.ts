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
  BigNumberish,
  ContractDeployTransaction,
  ContractRunner,
} from "ethers";
import type { NonPayableOverrides } from "../../../common";
import type {
  MyGuideDAOToken,
  MyGuideDAOTokenInterface,
} from "../../../contracts/practice-GuideDAO/MyGuideDAOToken";

const _abi = [
  {
    inputs: [
      {
        internalType: "uint256",
        name: "initialSupply",
        type: "uint256",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "allowance",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "needed",
        type: "uint256",
      },
    ],
    name: "ERC20InsufficientAllowance",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "sender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "balance",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "needed",
        type: "uint256",
      },
    ],
    name: "ERC20InsufficientBalance",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "approver",
        type: "address",
      },
    ],
    name: "ERC20InvalidApprover",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "receiver",
        type: "address",
      },
    ],
    name: "ERC20InvalidReceiver",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "sender",
        type: "address",
      },
    ],
    name: "ERC20InvalidSender",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
    ],
    name: "ERC20InvalidSpender",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "spender",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Approval",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "Transfer",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
      {
        internalType: "address",
        name: "spender",
        type: "address",
      },
    ],
    name: "allowance",
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
        name: "spender",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "approve",
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
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "balanceOf",
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
    name: "decimals",
    outputs: [
      {
        internalType: "uint8",
        name: "",
        type: "uint8",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "name",
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
    name: "symbol",
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
    name: "totalSupply",
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
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "transfer",
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
  {
    inputs: [
      {
        internalType: "address",
        name: "from",
        type: "address",
      },
      {
        internalType: "address",
        name: "to",
        type: "address",
      },
      {
        internalType: "uint256",
        name: "value",
        type: "uint256",
      },
    ],
    name: "transferFrom",
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
  "0x608060405234801561000f575f80fd5b50604051610b94380380610b9483398101604081905261002e91610202565b6040518060400160405280600781526020016626bcaa37b5b2b760c91b815250604051806040016040528060038152602001624d544b60e81b815250816003908161007991906102b1565b50600461008682826102b1565b505050610099338261009f60201b60201c565b50610390565b6001600160a01b0382166100cd5760405163ec442f0560e01b81525f60048201526024015b60405180910390fd5b6100d85f83836100dc565b5050565b6001600160a01b038316610106578060025f8282546100fb919061036b565b909155506101769050565b6001600160a01b0383165f90815260208190526040902054818110156101585760405163391434e360e21b81526001600160a01b038516600482015260248101829052604481018390526064016100c4565b6001600160a01b0384165f9081526020819052604090209082900390555b6001600160a01b038216610192576002805482900390556101b0565b6001600160a01b0382165f9081526020819052604090208054820190555b816001600160a01b0316836001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef836040516101f591815260200190565b60405180910390a3505050565b5f60208284031215610212575f80fd5b5051919050565b634e487b7160e01b5f52604160045260245ffd5b600181811c9082168061024157607f821691505b60208210810361025f57634e487b7160e01b5f52602260045260245ffd5b50919050565b601f8211156102ac57805f5260205f20601f840160051c8101602085101561028a5750805b601f840160051c820191505b818110156102a9575f8155600101610296565b50505b505050565b81516001600160401b038111156102ca576102ca610219565b6102de816102d8845461022d565b84610265565b6020601f821160018114610310575f83156102f95750848201515b5f19600385901b1c1916600184901b1784556102a9565b5f84815260208120601f198516915b8281101561033f578785015182556020948501946001909201910161031f565b508482101561035c57868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b8082018082111561038a57634e487b7160e01b5f52601160045260245ffd5b92915050565b6107f78061039d5f395ff3fe608060405234801561000f575f80fd5b506004361061009f575f3560e01c8063313ce5671161007257806395d89b411161005857806395d89b4114610140578063a9059cbb14610148578063dd62ed3e1461015b575f80fd5b8063313ce5671461010957806370a0823114610118575f80fd5b806306fdde03146100a3578063095ea7b3146100c157806318160ddd146100e457806323b872dd146100f6575b5f80fd5b6100ab610193565b6040516100b89190610617565b60405180910390f35b6100d46100cf366004610685565b610223565b60405190151581526020016100b8565b6002545b6040519081526020016100b8565b6100d46101043660046106ad565b61023c565b604051601281526020016100b8565b6100e86101263660046106e7565b6001600160a01b03165f9081526020819052604090205490565b6100ab61025f565b6100d4610156366004610685565b61026e565b6100e8610169366004610707565b6001600160a01b039182165f90815260016020908152604080832093909416825291909152205490565b6060600380546101a290610738565b80601f01602080910402602001604051908101604052809291908181526020018280546101ce90610738565b80156102195780601f106101f057610100808354040283529160200191610219565b820191905f5260205f20905b8154815290600101906020018083116101fc57829003601f168201915b5050505050905090565b5f3361023081858561027b565b60019150505b92915050565b5f3361024985828561028d565b610254858585610345565b506001949350505050565b6060600480546101a290610738565b5f33610230818585610345565b61028883838360016103d4565b505050565b6001600160a01b038381165f908152600160209081526040808320938616835292905220547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff811461033f5781811015610331576040517ffb8f41b20000000000000000000000000000000000000000000000000000000081526001600160a01b038416600482015260248101829052604481018390526064015b60405180910390fd5b61033f84848484035f6103d4565b50505050565b6001600160a01b038316610387576040517f96c6fd1e0000000000000000000000000000000000000000000000000000000081525f6004820152602401610328565b6001600160a01b0382166103c9576040517fec442f050000000000000000000000000000000000000000000000000000000081525f6004820152602401610328565b6102888383836104d8565b6001600160a01b038416610416576040517fe602df050000000000000000000000000000000000000000000000000000000081525f6004820152602401610328565b6001600160a01b038316610458576040517f94280d620000000000000000000000000000000000000000000000000000000081525f6004820152602401610328565b6001600160a01b038085165f908152600160209081526040808320938716835292905220829055801561033f57826001600160a01b0316846001600160a01b03167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925846040516104ca91815260200190565b60405180910390a350505050565b6001600160a01b038316610502578060025f8282546104f79190610789565b9091555061058b9050565b6001600160a01b0383165f908152602081905260409020548181101561056d576040517fe450d38c0000000000000000000000000000000000000000000000000000000081526001600160a01b03851660048201526024810182905260448101839052606401610328565b6001600160a01b0384165f9081526020819052604090209082900390555b6001600160a01b0382166105a7576002805482900390556105c5565b6001600160a01b0382165f9081526020819052604090208054820190555b816001600160a01b0316836001600160a01b03167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef8360405161060a91815260200190565b60405180910390a3505050565b602081525f82518060208401528060208501604085015e5f6040828501015260407fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0601f83011684010191505092915050565b80356001600160a01b0381168114610680575f80fd5b919050565b5f8060408385031215610696575f80fd5b61069f8361066a565b946020939093013593505050565b5f805f606084860312156106bf575f80fd5b6106c88461066a565b92506106d66020850161066a565b929592945050506040919091013590565b5f602082840312156106f7575f80fd5b6107008261066a565b9392505050565b5f8060408385031215610718575f80fd5b6107218361066a565b915061072f6020840161066a565b90509250929050565b600181811c9082168061074c57607f821691505b602082108103610783577f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b50919050565b80820180821115610236577f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffdfea2646970667358221220904c5cb2ee297769940d58e968089f95a5820e0c91f3a56964959c3f89bc5bcf64736f6c634300081a0033";

type MyGuideDAOTokenConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: MyGuideDAOTokenConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class MyGuideDAOToken__factory extends ContractFactory {
  constructor(...args: MyGuideDAOTokenConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    initialSupply: BigNumberish,
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(initialSupply, overrides || {});
  }
  override deploy(
    initialSupply: BigNumberish,
    overrides?: NonPayableOverrides & { from?: string }
  ) {
    return super.deploy(initialSupply, overrides || {}) as Promise<
      MyGuideDAOToken & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): MyGuideDAOToken__factory {
    return super.connect(runner) as MyGuideDAOToken__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): MyGuideDAOTokenInterface {
    return new Interface(_abi) as MyGuideDAOTokenInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): MyGuideDAOToken {
    return new Contract(address, _abi, runner) as unknown as MyGuideDAOToken;
  }
}
