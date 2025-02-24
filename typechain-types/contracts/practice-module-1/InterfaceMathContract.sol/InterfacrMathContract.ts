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
} from "../../../common";

export interface InterfacrMathContractInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "addNumber"
      | "divideNumber"
      | "multiplyNumber"
      | "subtractNumber"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "addNumber",
    values: [BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "divideNumber",
    values: [BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "multiplyNumber",
    values: [BigNumberish, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "subtractNumber",
    values: [BigNumberish, BigNumberish]
  ): string;

  decodeFunctionResult(functionFragment: "addNumber", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "divideNumber",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "multiplyNumber",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "subtractNumber",
    data: BytesLike
  ): Result;
}

export interface InterfacrMathContract extends BaseContract {
  connect(runner?: ContractRunner | null): InterfacrMathContract;
  waitForDeployment(): Promise<this>;

  interface: InterfacrMathContractInterface;

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

  addNumber: TypedContractMethod<
    [a: BigNumberish, b: BigNumberish],
    [bigint],
    "view"
  >;

  divideNumber: TypedContractMethod<
    [a: BigNumberish, b: BigNumberish],
    [bigint],
    "view"
  >;

  multiplyNumber: TypedContractMethod<
    [a: BigNumberish, b: BigNumberish],
    [bigint],
    "view"
  >;

  subtractNumber: TypedContractMethod<
    [a: BigNumberish, b: BigNumberish],
    [bigint],
    "view"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "addNumber"
  ): TypedContractMethod<[a: BigNumberish, b: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "divideNumber"
  ): TypedContractMethod<[a: BigNumberish, b: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "multiplyNumber"
  ): TypedContractMethod<[a: BigNumberish, b: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "subtractNumber"
  ): TypedContractMethod<[a: BigNumberish, b: BigNumberish], [bigint], "view">;

  filters: {};
}
