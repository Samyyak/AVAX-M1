// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";
import "./Explore.sol";
import "./Vault.sol";

contract Trading {
    Explore public exploreContract;
    Vault public vault;
    ERC20 public token;

    mapping(uint256 => uint256) public playerPrices;

    constructor(address exploreAddress, address vaultAddress, address tokenAddress) {
        exploreContract = Explore(exploreAddress);
        vault = Vault(vaultAddress);
        token = ERC20(tokenAddress);

        playerPrices[1] = 200; // Troop
        playerPrices[2] = 500; // Healer
        playerPrices[3] = 800; // Warrior
        playerPrices[4] = 1000; // Commander
        playerPrices[5] = 2500; // King
    }

    function trade(address from, address to, uint256 playerId) external {
        uint256 price = playerPrices[playerId];
        require(price > 0, "Invalid player ID");

        Explore.Player[] memory fromInventory = exploreContract.getInventory(from);
        bool hasPlayer = false;
        uint256 playerIndex;

        for (uint256 i = 0; i < fromInventory.length; i++) {
            if (fromInventory[i].playerId == playerId) {
                hasPlayer = true;
                playerIndex = i;
                break;
            }
        }

        require(hasPlayer, "Sender does not own the player");
        require(vault.balanceOf(to) >= price, "Recipient has insufficient balance");

        vault.transferTokens(to, from, price);

        exploreContract.removePlayer(from, playerIndex);
        exploreContract.addPlayer(to, fromInventory[playerIndex]);
    }
}
