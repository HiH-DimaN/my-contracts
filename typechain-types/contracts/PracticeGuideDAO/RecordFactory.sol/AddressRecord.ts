/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */
import type {
  BaseContract,
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
} from "../../../common";

export interface AddressRecordInterface extends Interface {
  getFunction(
    nameOrSignature: "getRecordType" | "record" | "setRecord" | "timeOfCreation"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "getRecordType",
    values?: undefined
  ): string;
  encodeFunctionData(functionFragment: "record", values?: undefined): string;
  encodeFunctionData(
    functionFragment: "setRecord",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "timeOfCreation",
    values?: undefined
  ): string;

  decodeFunctionResult(
    functionFragment: "getRecordType",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "record", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "setRecord", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "timeOfCreation",
    data: BytesLike
  ): Result;
}

export interface AddressRecord extends BaseContract {
  connect(runner?: ContractRunner | null): AddressRecord;
  waitForDeployment(): Promise<this>;

  interface: AddressRecordInterface;

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

  getRecordType: TypedContractMethod<[], [string], "view">;

  record: TypedContractMethod<[], [string], "view">;

  setRecord: TypedContractMethod<
    [newRecord: AddressLike],
    [void],
    "nonpayable"
  >;

  timeOfCreation: TypedContractMethod<[], [bigint], "view">;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "getRecordType"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "record"
  ): TypedContractMethod<[], [string], "view">;
  getFunction(
    nameOrSignature: "setRecord"
  ): TypedContractMethod<[newRecord: AddressLike], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "timeOfCreation"
  ): TypedContractMethod<[], [bigint], "view">;

  filters: {};
}