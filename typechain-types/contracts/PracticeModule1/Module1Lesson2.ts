/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
  BigNumberish,
  BytesLike,
  FunctionFragment,
  Result,
  Interface,
  AddressLike,
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedListener,
  TypedContractMethod,
} from "../../common";

export interface Module1Lesson2Interface extends Interface {
  getFunction(
    nameOrSignature:
      | "getBalance"
      | "myAddr"
      | "payments"
      | "reciveFunds"
      | "transferTo"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "getBalance",
    values: [AddressLike]
  ): string;
  encodeFunctionData(functionFragment: "myAddr", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "payments",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "reciveFunds",
    values?: undefined
  ): string;
  encodeFunctionData(
    functionFragment: "transferTo",
    values: [AddressLike, BigNumberish]
  ): string;

  decodeFunctionResult(functionFragment: "getBalance", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "myAddr", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "payments", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "reciveFunds",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "transferTo", data: BytesLike): Result;
}

export interface Module1Lesson2 extends BaseContract {
  connect(runner?: ContractRunner | null): Module1Lesson2;
  waitForDeployment(): Promise<this>;

  interface: Module1Lesson2Interface;

  queryFilter<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;
  queryFilter<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    fromBlockOrBlockhash?: string | number | undefined,
    toBlock?: string | number | undefined
  ): Promise<Array<TypedEventLog<TCEvent>>>;

  on<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  on<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  once<TCEvent extends TypedContractEvent>(
    event: TCEvent,
    listener: TypedListener<TCEvent>
  ): Promise<this>;
  once<TCEvent extends TypedContractEvent>(
    filter: TypedDeferredTopicFilter<TCEvent>,
    listener: TypedListener<TCEvent>
  ): Promise<this>;

  listeners<TCEvent extends TypedContractEvent>(
    event: TCEvent
  ): Promise<Array<TypedListener<TCEvent>>>;
  listeners(eventName?: string): Promise<Array<Listener>>;
  removeAllListeners<TCEvent extends TypedContractEvent>(
    event?: TCEvent
  ): Promise<this>;

  getBalance: TypedContractMethod<[targetAddr: AddressLike], [bigint], "view">;

  myAddr: TypedContractMethod<[], [string], "view">;

  payments: TypedContractMethod<[arg0: AddressLike], [bigint], "view">;

  reciveFunds: TypedContractMethod<[], [void], "payable">;

  transferTo: TypedContractMethod<
    [targetAddr: AddressLike, amount: BigNumberish],
    [void],
    "nonpayable"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "getBalance"
  ): TypedContractMethod<[targetAddr: AddressLike], [bigint], "view">;
  getFunction(
    nameOrSignature: "myAddr"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "payments"
  ): TypedContractMethod<[arg0: AddressLike], [bigint], "view">;
  getFunction(
    nameOrSignature: "reciveFunds"
  ): TypedContractMethod<[], [void], "payable">;
  getFunction(
    nameOrSignature: "transferTo"
  ): TypedContractMethod<
    [targetAddr: AddressLike, amount: BigNumberish],
    [void],
    "nonpayable"
  >;

  filters: {};
}