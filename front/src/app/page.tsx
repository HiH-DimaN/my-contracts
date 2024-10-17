"use client";

import React, { useState, useEffect, FormEvent } from "react";
import { ethers, JsonRpcSigner } from "ethers";
import { MusicShop_factory } from "@/typechain";
import { MusicShop } from "@/typechain";
import { BrowserProvider } from "ethers";
import Image from "next/image";

import ConnectWallet from "@/components/ConnectWallet";
import WaitingFromTransactionMessage from "@/components/WaitingFromTransactionMessaget";
import TransactionErrorMessage from "@/components/TransactionErrorMessage";
import WaitingForTransactionMessage from "./components/WaitingForTransactionMessage";
import { error } from "console";

const HARDHAT_NETWORK_ID = "0x539";
const MUSIC_SHOP_ADDRESS = "0x5fbdb2315678afecb367f032d93f642f64180aa3";

declare let window: any;

type CurrentConnectionProps = {
  provider: BrowserProvider | undefined;
  shop: MusicShop | undefined;
  signer: JsonRpcSigner | undefined;
};


export default function Home() {
  const [networkError, setNetworkError] = useState<string>();
  const [txBeingSent, setTxBeingSent] = useState<string>();
  const [transactionError, setTransactionError] = useState<any>();
  const [currentConnection, setCurrentConnection] = 
    useState<CurrentConnectionProps>();

  const _connectWallet = async () => {
    if (window.ethereum === undefined) {
      setNetworkError("Please install Metamask");

      
      return;
    }

    if (!(await _checkNetwork())) {
      return;
    }
    
    const [selectedAccount] = await window.ethereum.request({
      method: "eth_requestAccounts",
    });

    await _initialize(selectedAccount)

    window.ethereum.on(
      "accountChanged",
      async ([newAccount]: [newAccount: string]) => {
        if (newAccount === undefined) {
          return _resetState();
        }

        await _initialize(newAccount);
      }
    );

    window.ethereum.on("chainChanged", ([_networkId]: any) => {
      _resetState;

    });

  };

  const _initialize = async (slectedAccount: string) => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner(slectedAccount);

    setCurrentConnection({
      ...currentConnection,
      provider,
      signer,
      shop: MusicShop_factory.connect(MUSIC_SHOP_ADDRESS, signer),
    });
  };

  const _resetState = () => {
    setNetworkError(undefined);
    setTransactionError(undefined);
    setTxBeingSent(undefined);
    setCurrentConnection({
      provider: undefined,
      signer: undefined,
      shop: undefined,
    });
  };

  const _checkNetwork = async (): Promise<boolean> => {
    const chosenChainID = await window.ethereum.request({
      method: "eth_chainID",
    });

    if (chosenChainID === HARDHAT_NETWORK_ID) {
      return true;
    }

    setNetworkError("Please connect to Hardhat network (localhost:8545)!");
    
    return false;

  };

  const _dismissNetworkError = () => {
    setNetworkError(undefined);
  };

  const _dismissTransactionError = () => {
    setTransactionError(undefined)
  };

  const _getRpsErrorMessage = (error: any): string => {
    console.log(error);
    if (error.data) {
      return error.data.message
    }

    return error.mesage
  };

  return (
    <main>
      {!currentConnection?.signer&& (
        <ConnectWallet
          connectWallet={_connectWallet}
          networkError={networkError}
          dismiss={_dismissNetworkError}
        />  
      )}

      {currentConnection?.signer&& (
        <p>Your address: {currentConnection.signer.address}</p>
      )}

      {txBeingSent && <WaitingForTransactionMessage txHash={txBeingSent} />}

      {transactionError && (
        <TransactionErrorMessage
          message={_getRpsErrorMessage(transactionError)}
          dismiss={_dismissTransactionError}
        />
      )}
    </main>
  );
}
