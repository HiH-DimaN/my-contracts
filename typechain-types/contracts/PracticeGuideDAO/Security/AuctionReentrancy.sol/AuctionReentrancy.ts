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
} from "../../../../common";

export interface AuctionReentrancyInterface extends Interface {
  getFunction(nameOrSignature: "bid" | "bids" | "refund"): FunctionFragment;

  encodeFunctionData(functionFragment: "bid", values?: undefined): string;
  encodeFunctionData(functionFragment: "bids", values: [AddressLike]): string;
  encodeFunctionData(functionFragment: "refund", values?: undefined): string;

  decodeFunctionResult(functionFragment: "bid", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "bids", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "refund", data: BytesLike): Result;
}

export interface AuctionReentrancy extends BaseContract {
  connect(runner?: ContractRunner | null): AuctionReentrancy;
  waitForDeployment(): Promise<this>;

  interface: AuctionReentrancyInterface;

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

  bid: TypedContractMethod<[], [void], "payable">;

  bids: TypedContractMethod<[bidder: AddressLike], [bigint], "view">;

  refund: TypedContractMethod<[], [void], "nonpayable">;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "bid"
  ): TypedContractMethod<[], [void], "payable">;
  getFunction(
    nameOrSignature: "bids"
  ): TypedContractMethod<[bidder: AddressLike], [bigint], "view">;
  getFunction(
    nameOrSignature: "refund"
  ): TypedContractMethod<[], [void], "nonpayable">;

  filters: {};
}