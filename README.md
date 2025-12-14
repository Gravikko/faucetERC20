# faucetERC20

Minimal ERC-20 token + faucet for local development and testing.

## What

Simple ERC-20 token and a faucet contract to mint/distribute test tokens, plus a small frontend to request tokens.

## Requirements

* Foundry (`forge`, `cast`)
* Node.js (LTS) and npm

## Repo layout

```
/contracts            # Foundry project (Solidity sources, tests, scripts)
packages/frontend     # Frontend app (dev server, build)
```

## Quick start

```bash
git clone https://github.com/Gravikko/faucetERC20.git
cd faucetERC20
```

### Contracts (Foundry)

```bash
cd contracts
forge install
forge build
forge test
```

### Frontend

```bash
cd packages/frontend
npm ci
npm run dev     # start dev server
npm run build   # production build
```

Configure RPC endpoint and contract addresses in the frontend as needed.

## Testing

* Run `forge test` for Solidity tests.
* Use frontend scripts defined in `packages/frontend/package.json` for UI testing/build.

## Deploy & verify

* Deploy using `forge script` or your preferred tooling.
* Verify sources on block explorers using the standard verification procedures.

## License

No license file included. Add a `LICENSE` if you want to specify reuse terms.
 