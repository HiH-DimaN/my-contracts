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

export interface AddressRecordFactoryInterface extends Interface {
  getFunction(
    nameOrSignature: "addAddressRecord" | "recordsStorage"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "addAddressRecord",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "recordsStorage",
    values?: undefined
  ): string;

  decodeFunctionResult(
    functionFragment: "addAddressRecord",
    data: BytesLike
  ): Result;
  decodeFunctionResult(
    functionFragment: "recordsStorage",
    data: BytesLike
  ): Result;
}

export interface AddressRecordFactory extends BaseContract {
  connect(runner?: ContractRunner | null): AddressRecordFactory;
  waitForDeployment(): Promise<this>;

  interface: AddressRecordFactoryInterface;

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

  addAddressRecord: TypedContractMethod<
    [_record: AddressLike],
    [void],
    "nonpayable"
  >;

  recordsStorage: TypedContractMethod<[], [string], "view">;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "addAddressRecord"
  ): TypedContractMethod<[_record: AddressLike], [void], "nonpayable">;
  getFunction(
    nameOrSignature: "recordsStorage"
  ): TypedContractMethod<[], [string], "view">;

  filters: {};
}