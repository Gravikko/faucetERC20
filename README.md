# FAUCET_EDUCATION — Quick Start

This README explains how to **clone**, build, and run the project using **Option B** — *dependencies are not stored in the repository*. The repo contains only sources, configs, and lock files (`foundry.lock`, `package-lock.json`) so the build is reproducible but the dependency folders (`contracts/lib/`, `node_modules/`) are **not** committed.


## Requirements

* Git
* [Foundry](https://github.com/foundry-rs/foundry) (`forge`, `cast`) — installed and on PATH
* Node.js (LTS recommended) and npm

## Quick start (after `git clone`)

```bash
git clone <repo-url>
cd <repo>
```

### 1) Contracts (Foundry)

```bash
cd contracts

# download dependencies (creates contracts/lib/)
forge install

# build and run tests
forge build
forge test
```

> If `remappings.txt` exists, commit it. Also commit `foundry.lock` to pin dependency versions.

### 2) Frontend

```bash
cd ../packages/frontend

# install dependencies
npm ci

# run dev server
npm run dev

# or build for production
npm run build
```

---

## What should be committed

* `contracts/src/`, `contracts/test/`, `contracts/script/`
* `contracts/foundry.toml`, `contracts/foundry.lock`, `contracts/remappings.txt` (if present)
* `packages/frontend/package.json`, `packages/frontend/package-lock.json`
* README, deployment scripts, configs and all source code (not compiled/built artifacts)

---

## What should NOT be committed (gitignored)

* `contracts/lib/` — Foundry dependencies (OpenZeppelin, forge-std, etc.)
* `contracts/out/` — compiled artifacts
* `contracts/cache/`
* `**/node_modules/`

### Recommended `.gitignore` (place in repo root)

```gitignore
# Node
node_modules/
**/node_modules/

# Frontend
/packages/frontend/node_modules/

# Foundry / Solidity
/contracts/lib/
contracts/out/
contracts/cache/
forge-debug.log

# General
dist/
.env
*.log
.DS_Store
.vscode/
```

---

## Removing already committed dependencies / build artifacts

If `contracts/lib/` or `node_modules` were already committed, remove them from the git index (keeps local files intact):

```bash
# from repo root
git rm -r --cached contracts/lib || true
git rm -r --cached contracts/out || true
git rm -r --cached contracts/cache || true
git rm -r --cached packages/frontend/node_modules || true

git add .gitignore
git commit -m "Ignore deps and build artifacts (contracts/lib, node_modules, out, cache)"
```

> Note: This removes these files from the current HEAD only — history remains. If repo size is a problem, rewriting history with `git filter-repo` or BFG is required (advanced).

---

## Solidity import examples

Use standard imports. After `forge install` Foundry and remappings will resolve them:

```solidity
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

---

## CI (minimal steps)

In CI or GitHub Actions include these steps:

1. `cd contracts && forge install`
2. `forge build` / `forge test`
3. `cd ../packages/frontend && npm ci && npm run build`

Example (pseudocode):

```yaml
- name: Install Foundry
  run: curl -L https://foundry.paradigm.xyz | bash && foundryup

- name: Install contract deps
  working-directory: contracts
  run: forge install

- name: Run contract tests
  working-directory: contracts
  run: forge test

- name: Frontend install & build
  working-directory: packages/frontend
  run: |
    npm ci
    npm run build
```

---

## Common issues & fixes

* `Cannot find import` — you likely forgot `forge install` or `remappings.txt` is missing. Run `forge install`.
* Frontend build fails — ensure Node version compatibility; use `npm ci`.
* If someone clones and the `contracts/lib/` folder is missing, remind them to run `forge install`.
