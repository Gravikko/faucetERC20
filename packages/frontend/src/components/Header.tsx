import { ConnectButton } from "@rainbow-me/rainbowkit";
import * as React from 'react';

export default function Header() {
    return (
        <div className="flex w-full justify-center items-center p-20">
          <ConnectButton />
        </div>
      );
}