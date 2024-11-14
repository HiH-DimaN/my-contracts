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
  TodoList,
  TodoListInterface,
} from "../../../contracts/practice-GuideDAO/TodoList";

const _abi = [
  {
    inputs: [],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_title",
        type: "string",
      },
      {
        internalType: "string",
        name: "_description",
        type: "string",
      },
      {
        internalType: "bool",
        name: "_completed",
        type: "bool",
      },
    ],
    name: "addTodo",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_newTitile",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "index",
        type: "uint256",
      },
    ],
    name: "changeTitle",
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
    name: "changeTodoStatus",
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
    name: "getTodo",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
      {
        internalType: "string",
        name: "",
        type: "string",
      },
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
  "0x6080604052348015600e575f80fd5b505f80546001600160a01b031916331790556108d18061002d5f395ff3fe608060405234801561000f575f80fd5b506004361061004a575f3560e01c80638409b0d01461004e5780639e65f0b914610063578063a08e4dff14610076578063dd68afb614610089575b5f80fd5b61006161005c36600461052f565b6100b4565b005b6100616100713660046105b6565b6101e9565b6100616100843660046105cd565b6102a6565b61009c6100973660046105b6565b610332565b6040516100ab93929190610643565b60405180910390f35b5f5473ffffffffffffffffffffffffffffffffffffffff16331461010f5760405162461bcd60e51b815260206004820152600d60248201526c6e6f7420616e206f776e65722160981b60448201526064015b60405180910390fd5b6040805160806020601f880181900402820181019092526060810186815260019282919089908990819085018382808284375f92019190915250505090825250604080516020601f8801819004810282018101909252868152918101919087908790819084018382808284375f920182905250938552505050602091820181905283546001810185559381522081519192600302019081906101b19082610712565b50602082015160018201906101c69082610712565b50604091909101516002909101805460ff19169115159190911790555050505050565b5f5473ffffffffffffffffffffffffffffffffffffffff16331461023f5760405162461bcd60e51b815260206004820152600d60248201526c6e6f7420616e206f776e65722160981b6044820152606401610106565b60018181548110610252576102526107cd565b905f5260205f2090600302016002015f9054906101000a900460ff161560018281548110610282576102826107cd565b5f9182526020909120600390910201600201805460ff191691151591909117905550565b5f5473ffffffffffffffffffffffffffffffffffffffff1633146102fc5760405162461bcd60e51b815260206004820152600d60248201526c6e6f7420616e206f776e65722160981b6044820152606401610106565b828260018381548110610311576103116107cd565b905f5260205f2090600302015f01918261032c9291906107e1565b50505050565b5f8054606091829173ffffffffffffffffffffffffffffffffffffffff16331461038e5760405162461bcd60e51b815260206004820152600d60248201526c6e6f7420616e206f776e65722160981b6044820152606401610106565b5f600185815481106103a2576103a26107cd565b905f5260205f2090600302019050805f0181600101826002015f9054906101000a900460ff168280546103d49061068e565b80601f01602080910402602001604051908101604052809291908181526020018280546104009061068e565b801561044b5780601f106104225761010080835404028352916020019161044b565b820191905f5260205f20905b81548152906001019060200180831161042e57829003601f168201915b5050505050925081805461045e9061068e565b80601f016020809104026020016040519081016040528092919081815260200182805461048a9061068e565b80156104d55780601f106104ac576101008083540402835291602001916104d5565b820191905f5260205f20905b8154815290600101906020018083116104b857829003601f168201915b50505050509150935093509350509193909250565b5f8083601f8401126104fa575f80fd5b50813567ffffffffffffffff811115610511575f80fd5b602083019150836020828501011115610528575f80fd5b9250929050565b5f805f805f60608688031215610543575f80fd5b853567ffffffffffffffff811115610559575f80fd5b610565888289016104ea565b909650945050602086013567ffffffffffffffff811115610584575f80fd5b610590888289016104ea565b909450925050604086013580151581146105a8575f80fd5b809150509295509295909350565b5f602082840312156105c6575f80fd5b5035919050565b5f805f604084860312156105df575f80fd5b833567ffffffffffffffff8111156105f5575f80fd5b610601868287016104ea565b909790965060209590950135949350505050565b5f81518084528060208401602086015e5f602082860101526020601f19601f83011685010191505092915050565b606081525f6106556060830186610615565b82810360208401526106678186610615565b9150508215156040830152949350505050565b634e487b7160e01b5f52604160045260245ffd5b600181811c908216806106a257607f821691505b6020821081036106c057634e487b7160e01b5f52602260045260245ffd5b50919050565b601f82111561070d57805f5260205f20601f840160051c810160208510156106eb5750805b601f840160051c820191505b8181101561070a575f81556001016106f7565b50505b505050565b815167ffffffffffffffff81111561072c5761072c61067a565b6107408161073a845461068e565b846106c6565b6020601f821160018114610772575f831561075b5750848201515b5f19600385901b1c1916600184901b17845561070a565b5f84815260208120601f198516915b828110156107a15787850151825560209485019460019092019101610781565b50848210156107be57868401515f19600387901b60f8161c191681555b50505050600190811b01905550565b634e487b7160e01b5f52603260045260245ffd5b67ffffffffffffffff8311156107f9576107f961067a565b61080d83610807835461068e565b836106c6565b5f601f84116001811461083e575f85156108275750838201355b5f19600387901b1c1916600186901b17835561070a565b5f83815260208120601f198716915b8281101561086d578685013582556020948501946001909201910161084d565b5086821015610889575f1960f88860031b161c19848701351681555b505060018560011b018355505050505056fea2646970667358221220dbec77ae928f6a5dce3f5a9092a4479e07623c3313b166931062aff8bf28a2f364736f6c634300081a0033";

type TodoListConstructorParams =
  | [signer?: Signer]
  | ConstructorParameters<typeof ContractFactory>;

const isSuperArgs = (
  xs: TodoListConstructorParams
): xs is ConstructorParameters<typeof ContractFactory> => xs.length > 1;

export class TodoList__factory extends ContractFactory {
  constructor(...args: TodoListConstructorParams) {
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
      TodoList & {
        deploymentTransaction(): ContractTransactionResponse;
      }
    >;
  }
  override connect(runner: ContractRunner | null): TodoList__factory {
    return super.connect(runner) as TodoList__factory;
  }

  static readonly bytecode = _bytecode;
  static readonly abi = _abi;
  static createInterface(): TodoListInterface {
    return new Interface(_abi) as TodoListInterface;
  }
  static connect(address: string, runner?: ContractRunner | null): TodoList {
    return new Contract(address, _abi, runner) as unknown as TodoList;
  }
}