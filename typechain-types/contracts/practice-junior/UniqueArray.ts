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
  EventFragment,
  ContractRunner,
  ContractMethod,
  Listener,
} from "ethers";
import type {
  TypedContractEvent,
  TypedDeferredTopicFilter,
  TypedEventLog,
  TypedLogDescription,
  TypedListener,
  TypedContractMethod,
} from "../../common";

export interface UniqueArrayInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "addUniqueValues"
      | "getValue"
      | "getValues"
      | "uniqueValues"
  ): FunctionFragment;

  getEvent(nameOrSignatureOrTopic: "AddedValue"): EventFragment;

  encodeFunctionData(
    functionFragment: "addUniqueValues",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getValue",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(functionFragment: "getValues", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "uniqueValues",
    values: [BigNumberish]
  ): string;

  decodeFunctionResult(
    functionFragment: "addUniqueValues",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "getValue", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "getValues", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "uniqueValues",
    data: BytesLike
  ): Result;
}

export namespace AddedValueEvent {
  export type InputTuple = [_value: BigNumberish];
  export type OutputTuple = [_value: bigint];
  export interface OutputObject {
    _value: bigint;
  }
  export type Event = TypedContractEvent<InputTuple, OutputTuple, OutputObject>;
  export type Filter = TypedDeferredTopicFilter<Event>;
  export type Log = TypedEventLog<Event>;
  export type LogDescription = TypedLogDescription<Event>;
}

export interface UniqueArray extends BaseContract {
  connect(runner?: ContractRunner | null): UniqueArray;
  waitForDeployment(): Promise<this>;

  interface: UniqueArrayInterface;

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

  addUniqueValues: TypedContractMethod<
    [_value: BigNumberish],
    [void],
    "nonpayable"
  >;

  getValue: TypedContractMethod<[index: BigNumberish], [bigint], "view">;

  getValues: TypedContractMethod<[], [bigint[]], "view">;

  uniqueValues: TypedContractMethod<[arg0: BigNumberish], [bigint], "view">;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "addUniqueValues"
  ): TypedContractMethod<[_value: BigNumberish], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "getValue"
  ): TypedContractMethod<[index: BigNumberish], [bigint], "view">;
  getFunction(
    nameOrSignature: "getValues"
  ): TypedContractMethod<[], [bigint[]], "view">;
  getFunction(
    nameOrSignature: "uniqueValues"
  ): TypedContractMethod<[arg0: BigNumberish], [bigint], "view">;

  getEvent(
    key: "AddedValue"
  ): TypedContractEvent<
    AddedValueEvent.InputTuple,
    AddedValueEvent.OutputTuple,
    AddedValueEvent.OutputObject
  >;

  filters: {
    "AddedValue(uint256)": TypedContractEvent<
      AddedValueEvent.InputTuple,
      AddedValueEvent.OutputTuple,
      AddedValueEvent.OutputObject
    >;
    AddedValue: TypedContractEvent<
      AddedValueEvent.InputTuple,
      AddedValueEvent.OutputTuple,
      AddedValueEvent.OutputObject
    >;
  };
}