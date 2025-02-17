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

export declare namespace UserRegistry {
  export type UserStruct = {
    name: string;
    age: BigNumberish;
    isActive: boolean;
    flags: BigNumberish;
  };

  export type UserStructOutput = [
    name: string,
    age: bigint,
    isActive: boolean,
    flags: bigint
  ] & { name: string; age: bigint; isActive: boolean; flags: bigint };
}

export interface UserRegistryInterface extends Interface {
  getFunction(
    nameOrSignature:
      | "getFlag"
      | "getUser"
      | "registerUser"
      | "setFlag"
      | "users"
  ): FunctionFragment;

  encodeFunctionData(
    functionFragment: "getFlag",
    values: [BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "getUser",
    values: [AddressLike]
  ): string;
  encodeFunctionData(
    functionFragment: "registerUser",
    values: [string, BigNumberish]
  ): string;
  encodeFunctionData(
    functionFragment: "setFlag",
    values: [BigNumberish, boolean]
  ): string;
  encodeFunctionData(functionFragment: "users", values: [AddressLike]): string;

  decodeFunctionResult(functionFragment: "getFlag", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "getUser", data: BytesLike): Result;
  decodeFunctionResult(
    functionFragment: "registerUser",
    data: BytesLike
  ): Result;
  decodeFunctionResult(functionFragment: "setFlag", data: BytesLike): Result;
  decodeFunctionResult(functionFragment: "users", data: BytesLike): Result;
}

export interface UserRegistry extends BaseContract {
  connect(runner?: ContractRunner | null): UserRegistry;
  waitForDeployment(): Promise<this>;

  interface: UserRegistryInterface;

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

  getFlag: TypedContractMethod<[_flagIndex: BigNumberish], [boolean], "view">;

  getUser: TypedContractMethod<
    [_userAddress: AddressLike],
    [UserRegistry.UserStructOutput],
    "view"
  >;

  registerUser: TypedContractMethod<
    [_name: string, _age: BigNumberish],
    [void],
    "nonpayable"
  >;

  setFlag: TypedContractMethod<
    [_flagIndex: BigNumberish, _value: boolean],
    [void],
    "nonpayable"
  >;

  users: TypedContractMethod<
    [arg0: AddressLike],
    [
      [string, bigint, boolean, bigint] & {
        name: string;
        age: bigint;
        isActive: boolean;
        flags: bigint;
      }
    ],
    "view"
  >;

  getFunction<T extends ContractMethod = ContractMethod>(
    key: string | FunctionFragment
  ): T;

  getFunction(
    nameOrSignature: "getFlag"
  ): TypedContractMethod<[_flagIndex: BigNumberish], [boolean], "view">;
  getFunction(
    nameOrSignature: "getUser"
  ): TypedContractMethod<
    [_userAddress: AddressLike],
    [UserRegistry.UserStructOutput],
    "view"
  >;
  getFunction(
    nameOrSignature: "registerUser"
  ): TypedContractMethod<
    [_name: string, _age: BigNumberish],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "setFlag"
  ): TypedContractMethod<
    [_flagIndex: BigNumberish, _value: boolean],
    [void],
    "nonpayable"
  >;
  getFunction(
    nameOrSignature: "users"
  ): TypedContractMethod<
    [arg0: AddressLike],
    [
      [string, bigint, boolean, bigint] & {
        name: string;
        age: bigint;
        isActive: boolean;
        flags: bigint;
      }
    ],
    "view"
  >;

  filters: {};
}
