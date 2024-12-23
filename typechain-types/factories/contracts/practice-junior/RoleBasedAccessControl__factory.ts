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
import type { NonPayableOverrides } from "../../../common";
import type {
  RoleBasedAccessControl,
  RoleBasedAccessControlInterface,
} from "../../../contracts/practice-junior/RoleBasedAccessControl";

const _abi = [
  {
    inputs: [
      {
        internalType: "address",
        name: "initialAdmin",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "AccessControlBadConfirmation",
    type: "error",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        internalType: "bytes32",
        name: "neededRole",
        type: "bytes32",
      },
    ],
    name: "AccessControlUnauthorizedAccount",
    type: "error",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "previousAdminRole",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "bytes32",
        name: "newAdminRole",
        type: "bytes32",
      },
    ],
    name: "RoleAdminChanged",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "sender",
        type: "address",
      },
    ],
    name: "RoleGranted",
    type: "event",
  },
  {
    anonymous: false,
    inputs: [
      {
        indexed: true,
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        indexed: true,
        internalType: "address",
        name: "account",
        type: "address",
      },
      {
        indexed: true,
        internalType: "address",
        name: "sender",
        type: "address",
      },
    ],
    name: "RoleRevoked",
    type: "event",
  },
  {
    inputs: [],
    name: "ADMIN_ROLE",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "DEFAULT_ADMIN_ROLE",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "USER_ROLE",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
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
    name: "addUser",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "adminFunction",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
    ],
    name: "getRoleAdmin",
    outputs: [
      {
        internalType: "bytes32",
        name: "",
        type: "bytes32",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "grantRole",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "hasRole",
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
        name: "account",
        type: "address",
      },
    ],
    name: "removeUser",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "callerConfirmation",
        type: "address",
      },
    ],
    name: "renounceRole",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes32",
        name: "role",
        type: "bytes32",
      },
      {
        internalType: "address",
        name: "account",
        type: "address",
      },
    ],
    name: "revokeRole",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "bytes4",
        name: "interfaceId",
        type: "bytes4",
      },
    ],
    name: "supportsInterface",
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
    name: "userFunction",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
] as const;

const _bytecode =
  "0x608060405234801561000f575f80fd5b5060405161086738038061086783398101604081905261002e91610133565b6100587fa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c217758261008a565b506100837f14823911f2da1b49f045a0929a60b8c1f2a7fc8c06c7284ca3e8ab4e193a08c88261008a565b5050610160565b5f828152602081815260408083206001600160a01b038516845290915281205460ff1661012a575f838152602081815260408083206001600160a01b03861684529091529020805460ff191660011790556100e23390565b6001600160a01b0316826001600160a01b0316847f2f8788117e7eff1d82e926ec794901d17c78024a50270940304540a733656f0d60405160405180910390a450600161012d565b505f5b92915050565b5f60208284031215610143575f80fd5b81516001600160a01b0381168114610159575f80fd5b9392505050565b6106fa8061016d5f395ff3fe608060405234801561000f575f80fd5b50600436106100da575f3560e01c8063421b2d8b1161008857806391d148541161006357806391d14854146101cf5780639857518814610205578063a217fddf14610218578063d547741f1461021f575f80fd5b8063421b2d8b1461018d57806372ed9987146101a057806375b238fc146101a8575f80fd5b80632f2ff15d116100b85780632f2ff15d1461015d57806336568abe14610172578063381f76ec14610185575f80fd5b806301ffc9a7146100de5780631311916114610106578063248a9ca31461013b575b5f80fd5b6100f16100ec366004610609565b610232565b60405190151581526020015b60405180910390f35b61012d7f14823911f2da1b49f045a0929a60b8c1f2a7fc8c06c7284ca3e8ab4e193a08c881565b6040519081526020016100fd565b61012d61014936600461064f565b5f9081526020819052604090206001015490565b61017061016b366004610681565b6102ca565b005b610170610180366004610681565b6102f4565b610170610345565b61017061019b3660046106ab565b610372565b6101706103ca565b61012d7fa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c2177581565b6100f16101dd366004610681565b5f918252602082815260408084206001600160a01b0393909316845291905290205460ff1690565b6101706102133660046106ab565b6103f4565b61012d5f81565b61017061022d366004610681565b610444565b5f7fffffffff0000000000000000000000000000000000000000000000000000000082167f7965db0b0000000000000000000000000000000000000000000000000000000014806102c457507f01ffc9a7000000000000000000000000000000000000000000000000000000007fffffffff000000000000000000000000000000000000000000000000000000008316145b92915050565b5f828152602081905260409020600101546102e481610468565b6102ee8383610472565b50505050565b6001600160a01b0381163314610336576040517f6697b23200000000000000000000000000000000000000000000000000000000815260040160405180910390fd5b6103408282610519565b505050565b7f14823911f2da1b49f045a0929a60b8c1f2a7fc8c06c7284ca3e8ab4e193a08c861036f81610468565b50565b7fa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c2177561039c81610468565b6103c67f14823911f2da1b49f045a0929a60b8c1f2a7fc8c06c7284ca3e8ab4e193a08c8836102ca565b5050565b7fa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c2177561036f81610468565b7fa49807205ce4d355092ef5a8a18f56e8913cf4a201fbe287825b095693c2177561041e81610468565b6103c67f14823911f2da1b49f045a0929a60b8c1f2a7fc8c06c7284ca3e8ab4e193a08c8835b5f8281526020819052604090206001015461045e81610468565b6102ee8383610519565b61036f813361059a565b5f828152602081815260408083206001600160a01b038516845290915281205460ff16610512575f838152602081815260408083206001600160a01b03861684529091529020805460ff191660011790556104ca3390565b6001600160a01b0316826001600160a01b0316847f2f8788117e7eff1d82e926ec794901d17c78024a50270940304540a733656f0d60405160405180910390a45060016102c4565b505f6102c4565b5f828152602081815260408083206001600160a01b038516845290915281205460ff1615610512575f838152602081815260408083206001600160a01b0386168085529252808320805460ff1916905551339286917ff6391f5c32d9c69d2a47ea670b442974b53935d1edc7fd64eb21e047a839171b9190a45060016102c4565b5f828152602081815260408083206001600160a01b038516845290915290205460ff166103c6576040517fe2517d3f0000000000000000000000000000000000000000000000000000000081526001600160a01b03821660048201526024810183905260440160405180910390fd5b5f60208284031215610619575f80fd5b81357fffffffff0000000000000000000000000000000000000000000000000000000081168114610648575f80fd5b9392505050565b5f6020828403121561065f575f80fd5b5035919050565b80356001600160a01b038116811461067c575f80fd5b919050565b5f8060408385031215610692575f80fd5b823591506106a260208401610666565b90509250929050565b5f602082840312156106bb575f80fd5b6106488261066656fea26469706673582212206b29ba8a9d77becad727fd72d9368a749fc89ae071ab90c442f5ed554882f9a064736f6c634300081a0033";

type RoleBasedAccessControlConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: RoleBasedAccessControlConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class RoleBasedAccessControl__factory extends ContractFactory {
  constructor(...args: RoleBasedAccessControlConstructorParams) {
    if (isSuperArgs(args)) {
      super(...args);
    } else {
      super(_abi, _bytecode, args[0]);
    }
  }

  override getDeployTransaction(
    initialAdmin: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ): Promise<ContractDeployTransaction> {
    return super.getDeployTransaction(initialAdmin, overrides || {});
  }
  override deploy(
    initialAdmin: AddressLike,
    overrides?: NonPayableOverrides & { from?: string }
  ) {
    return super.deploy(initialAdmin, overrides || {}) as Promise<
      RoleBasedAccessControl & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(
    runner: ContractRunner | null
  ): RoleBasedAccessControl__factory {
    return super.connect(runner) as RoleBasedAccessControl__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): RoleBasedAccessControlInterface {
    return new Interface(_abi) as RoleBasedAccessControlInterface;
  }
  static connect(
    address: string,
    runner?: ContractRunner | null
  ): RoleBasedAccessControl {
    return new Contract(
      address,
      _abi,
      runner
    ) as unknown as RoleBasedAccessControl;
  }
}
