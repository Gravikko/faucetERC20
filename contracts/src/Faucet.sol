// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
 
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract FaucetToken is ERC20, Ownable {
    mapping(address => uint256) private _lastRequestAt;
    uint256 public constant MAXIMUM_MINT_AMOUNT = 100 * 1e18; // 100 tokens
    uint256 public constant COOLDOWN = 10 seconds;

    /* Errors */
    error InvalidAmount();
    error AddressUnderCoolDown();

    /* Events */
    event FaucetRequested(address indexed to, uint256 amount);

    constructor(address initialOwner) 
        ERC20("FaucetToken", "FCT")
        Ownable(initialOwner)
    {}

    function faucet(uint256 amount) external {
        if (amount == 0 || amount > MAXIMUM_MINT_AMOUNT) revert InvalidAmount();
        if (block.timestamp < _lastRequestAt[msg.sender] + COOLDOWN) revert AddressUnderCoolDown();

        _lastRequestAt[msg.sender] = block.timestamp;
        _mint(msg.sender, amount);
        emit FaucetRequested(msg.sender, amount);
    }

    function lastRequestedAt(address to) external view returns(uint256) {
        return _lastRequestAt[to];
    }
}