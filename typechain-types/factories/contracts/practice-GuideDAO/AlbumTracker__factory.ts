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
  AlbumTracker,
  AlbumTrackerInterface,
} from "../../../contracts/practice-GuideDAO/AlbumTracker";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "owner",
        type: "address",
      },
    ],
    name: "OwnableInvalidOwner",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "OwnableUnauthorizedAccount",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: false,
        internalType: "uint256",
        name: "_albumIndex",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "uint256",
        name: "_stateNum",
        type: "uint256",
      },
      {
        indexed: false,
        internalType: "address",
        name: "_albuumAddress",
        type: "address",
      },
    ],
    name: "AlbumStateChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "address",
        name: "previousOwner",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "OwnershipTransferred",
    type: "event",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    name: "albums",
    outputs: [
      {
        internalType: "contract Album",
        name: "album",
        type: "address",
      },
      {
        internalType: "enum AlbumTracker.AlbumState",
        name: "state",
        type: "uint8",
      },
      {
        internalType: "uint256",
        name: "price",
        type: "uint256",
      },
      {
        internalType: "string",
        name: "title",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_price",
        type: "uint256",
      },
      {
        internalType: "string",
        name: "_title",
        type: "string",
      },
    ],
    name: "creatAlbum",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "owner",
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
    name: "renounceOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "newOwner",
        type: "address",
      },
    ],
    name: "transferOwnership",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_index",
        type: "uint256",
      },
    ],
    name: "triggerDelivery",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_index",
        type: "uint256",
      },
    ],
    name: "triggerPayment",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x6080604052348015600e575f80fd5b503380603357604051631e4fbdf760e01b81525f600482015260240160405180910390fd5b603a81603f565b50608e565b5f80546001600160a01b038381166001600160a01b0319831681178455604051919092169283917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e09190a35050565b61117a8061009b5f395ff3fe60806040526004361061006e575f3560e01c80638da5cb5b1161004c5780638da5cb5b146100ba578063cd31831e146100e5578063ea5df05914610104578063f2fde38b14610133575f80fd5b80631106ff5514610072578063715018a614610093578063800fb83f146100a7575b5f80fd5b34801561007d575f80fd5b5061009161008c366004610708565b610152565b005b34801561009e575f80fd5b506100916102b8565b6100916100b53660046107c6565b6102cb565b3480156100c5575f80fd5b505f546040516001600160a01b0390911681526020015b60405180910390f35b3480156100f0575f80fd5b506100916100ff3660046107c6565b61046f565b34801561010f575f80fd5b5061012361011e3660046107c6565b610527565b6040516100dc949392919061081f565b34801561013e575f80fd5b5061009161014d366004610872565b6105e5565b61015a61063b565b5f82826002543060405161016d906106e7565b61017a949392919061089f565b604051809103905ff080158015610193573d5f803e3d5ffd5b50600280545f90815260016020819052604080832080547fffffffffffffffffffffffff0000000000000000000000000000000000000000166001600160a01b0387161790558354835280832080547fffffffffffffffffffffff00ffffffffffffffffffffffffffffffffffffffff1690558354835280832090910187905582548252902091925001610227838261095b565b50600280545f818152600160205260409020547f8542b8ef60da7608cbc49312726af0237d477014a139780ee36ae926f53f30d192600160a01b90910460ff1690811115610277576102776107dd565b6040805192835260208301919091526001600160a01b0384169082015260600160405180910390a160028054905f6102ae83610a16565b9190505550505050565b6102c061063b565b6102c95f610680565b565b5f8082815260016020526040902054600160a01b900460ff1660028111156102f5576102f56107dd565b146103475760405162461bcd60e51b815260206004820181905260248201527f5468697320616c62756d20697320616c7265616479207075726368617365642160448201526064015b60405180910390fd5b5f818152600160208190526040909120015434146103a75760405162461bcd60e51b815260206004820152601d60248201527f576520616363657074206f6e6c792066756c6c207061796d656e747321000000604482015260640161033e565b5f81815260016020819052604090912080547fffffffffffffffffffffff00ffffffffffffffffffffffffffffffffffffffff16600160a01b835b02179055505f818152600160205260409020547f8542b8ef60da7608cbc49312726af0237d477014a139780ee36ae926f53f30d1908290600160a01b900460ff166002811115610434576104346107dd565b5f84815260016020908152604091829020548251948552908401929092526001600160a01b039091169082015260600160405180910390a150565b60015f82815260016020526040902054600160a01b900460ff16600281111561049a5761049a6107dd565b146104e75760405162461bcd60e51b815260206004820152601b60248201527f5468697320616c62756d206973206e6f74207061696420666f72210000000000604482015260640161033e565b5f8181526001602052604090208054600291907fffffffffffffffffffffff00ffffffffffffffffffffffffffffffffffffffff16600160a01b836103e2565b600160208190525f91825260409091208054918101546002820180546001600160a01b03851694600160a01b900460ff16939190610564906108d7565b80601f0160208091040260200160405190810160405280929190818152602001828054610590906108d7565b80156105db5780601f106105b2576101008083540402835291602001916105db565b820191905f5260205f20905b8154815290600101906020018083116105be57829003601f168201915b5050505050905084565b6105ed61063b565b6001600160a01b03811661062f576040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081525f600482015260240161033e565b61063881610680565b50565b5f546001600160a01b031633146102c9576040517f118cdaa700000000000000000000000000000000000000000000000000000000815233600482015260240161033e565b5f80546001600160a01b038381167fffffffffffffffffffffffff0000000000000000000000000000000000000000831681178455604051919092169283917f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e09190a35050565b61070a80610a3b83390190565b634e487b7160e01b5f52604160045260245ffd5b5f8060408385031215610719575f80fd5b82359150602083013567ffffffffffffffff811115610736575f80fd5b8301601f81018513610746575f80fd5b803567ffffffffffffffff811115610760576107606106f4565b604051601f19603f601f19601f8501160116810181811067ffffffffffffffff82111715610790576107906106f4565b6040528181528282016020018710156107a7575f80fd5b816020840160208301375f602083830101528093505050509250929050565b5f602082840312156107d6575f80fd5b5035919050565b634e487b7160e01b5f52602160045260245ffd5b5f81518084528060208401602086015e5f602082860101526020601f19601f83011685010191505092915050565b6001600160a01b03851681525f6003851061084857634e487b7160e01b5f52602160045260245ffd5b8460208301528360408301526080606083015261086860808301846107f1565b9695505050505050565b5f60208284031215610882575f80fd5b81356001600160a01b0381168114610898575f80fd5b9392505050565b848152608060208201525f6108b760808301866107f1565b90508360408301526001600160a01b038316606083015295945050505050565b600181811c908216806108eb57607f821691505b60208210810361090957634e487b7160e01b5f52602260045260245ffd5b50919050565b601f82111561095657805f5260205f20601f840160051c810160208510156109345750805b601f840160051c820191505b81811015610953575f8155600101610940565b50505b505050565b815167ffffffffffffffff811115610975576109756106f4565b6109898161098384546108d7565b8461090f565b6020601f8211600181146109bb575f83156109a45750848201515b5f19600385901b1c1916600184901b178455610953565b5f84815260208120601f198516915b828110156109ea57878501518255602094850194600190920191016109ca565b5084821015610a0757868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b5f5f198203610a3357634e487b7160e01b5f52601160045260245ffd5b506001019056fe608060405234801561000f575f80fd5b5060405161070a38038061070a83398101604081905261002e9161009b565b5f849055600161003e84826101f5565b50600391909155600480546001600160a01b0319166001600160a01b03909216919091179055506102af9050565b634e487b7160e01b5f52604160045260245ffd5b80516001600160a01b0381168114610096575f80fd5b919050565b5f805f80608085870312156100ae575f80fd5b845160208601519094506001600160401b038111156100cb575f80fd5b8501601f810187136100db575f80fd5b80516001600160401b038111156100f4576100f461006c565b604051601f8201601f19908116603f011681016001600160401b03811182821017156101225761012261006c565b604052818152828201602001891015610139575f80fd5b8160208401602083015e5f9181016020019190915260408701519094509250610166905060608601610080565b905092959194509250565b600181811c9082168061018557607f821691505b6020821081036101a357634e487b7160e01b5f52602260045260245ffd5b50919050565b601f8211156101f057805f5260205f20601f840160051c810160208510156101ce5750805b601f840160051c820191505b818110156101ed575f81556001016101da565b50505b505050565b81516001600160401b0381111561020e5761020e61006c565b6102228161021c8454610171565b846101a9565b6020601f821160018114610254575f831561023d5750848201515b5f19600385901b1c1916600184901b1784556101ed565b5f84815260208120601f198516915b828110156102835787850151825560209485019460019092019101610263565b50848210156102a057868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b61044e806102bc5f395ff3fe608060405260043610610041575f3560e01c80632986c0e51461026a5780634a79d50c14610292578063879f9c96146102b3578063a035b1fe146102dc575f80fd5b366102665760025460ff161561009e5760405162461bcd60e51b815260206004820181905260248201527f5468697320616c62756d20697320616c7265616479207075726368617365642160448201526064015b60405180910390fd5b345f54146100ee5760405162461bcd60e51b815260206004820152601d60248201527f576520616363657074206f6e6c792066756c6c207061796d656e7473210000006044820152606401610095565b60045460035460405160248101919091525f9173ffffffffffffffffffffffffffffffffffffffff1690349060440160408051601f198184030181529181526020820180517bffffffffffffffffffffffffffffffffffffffffffffffffffffffff167f800fb83f0000000000000000000000000000000000000000000000000000000017905251610180919061037c565b5f6040518083038185875af1925050503d805f81146101ba576040519150601f19603f3d011682016040523d82523d5f602084013e6101bf565b606091505b50509050806102365760405162461bcd60e51b815260206004820152602d60248201527f536f7272792c20776520636f756c64206e6f742070726f6365737320796f757260448201527f207472616e73616374696f6e2e000000000000000000000000000000000000006064820152608401610095565b600280547fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff00166001908117909155005b5f80fd5b348015610275575f80fd5b5061027f60035481565b6040519081526020015b60405180910390f35b34801561029d575f80fd5b506102a66102f0565b6040516102899190610392565b3480156102be575f80fd5b506002546102cc9060ff1681565b6040519015158152602001610289565b3480156102e7575f80fd5b5061027f5f5481565b600180546102fd906103c7565b80601f0160208091040260200160405190810160405280929190818152602001828054610329906103c7565b80156103745780601f1061034b57610100808354040283529160200191610374565b820191905f5260205f20905b81548152906001019060200180831161035757829003601f168201915b505050505081565b5f82518060208501845e5f920191825250919050565b602081525f82518060208401528060208501604085015e5f604082850101526040601f19601f83011684010191505092915050565b600181811c908216806103db57607f821691505b602082108103610412577f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5091905056fea2646970667358221220622577ec64ff553c702948322002582b6767fde6c1800207a06038921fad931764736f6c634300081a0033a2646970667358221220fa94b11db69d0ed5a68a7dcc742bc3e80eafa973f0de113b508f333a1b9ce8b064736f6c634300081a0033";

type AlbumTrackerConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: AlbumTrackerConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class AlbumTracker__factory extends ContractFactory {
  constructor(...args: AlbumTrackerConstructorParams) {
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
      AlbumTracker & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): AlbumTracker__factory {
    return super.connect(runner) as AlbumTracker__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): AlbumTrackerInterface {
    return new Interface(_abi) as AlbumTrackerInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): AlbumTracker {
    return new Contract(address, _abi, runner) as unknown as AlbumTracker;
  }
}