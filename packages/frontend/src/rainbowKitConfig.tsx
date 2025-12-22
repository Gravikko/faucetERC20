"use client"

import {getDefaultConfig} from "@rainbow-me/rainbowkit"

import {anvil, sepolia, mainnet} from "wagmi/chains"

const projectId = import.meta.env.VITE_WALLETCONNECT_PROJECT_ID;

export default getDefaultConfig({
    appName: "Faucet",
    projectId: projectId,
    chains: [anvil, sepolia, mainnet],
    ssr: false
})