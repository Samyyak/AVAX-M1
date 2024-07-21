// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";
import "./Explore.sol";
import "./Vault.sol";

contract Combat {
    Explore public exploreContract;
    Vault public vault;
    ERC20 public token;

    struct Combatant {
        address user;
        uint256 power;
    }

    mapping(address => Combatant) public combatants;

    event CombatResult(address indexed winner, address indexed loser, uint256 amountWon);

    constructor(address exploreAddress, address vaultAddress, address tokenAddress) {
        exploreContract = Explore(exploreAddress);
        vault = Vault(vaultAddress);
        token = ERC20(tokenAddress);
    }

    function registerCombat() external {
        require(vault.balanceOf(msg.sender) >= 500, "Insufficient tokens for combat registration");

        Explore.Player[] memory inventory = exploreContract.getInventory(msg.sender);
        uint256 totalPower = calculatePower(inventory);

        combatants[msg.sender] = Combatant({
            user: msg.sender,
            power: totalPower
        });
    }

    function calculatePower(Explore.Player[] memory inventory) public pure returns (uint256) {
        uint256 totalPower = 0;
        for (uint256 i = 0; i < inventory.length; i++) {
            totalPower += inventory[i].power;
        }
        return totalPower;
    }

    function combat(address opponent) external {
        require(combatants[msg.sender].user != address(0), "Sender is not registered for combat");
        require(combatants[opponent].user != address(0), "Opponent is not registered for combat");

        address winner;
        address loser;
        if (combatants[msg.sender].power > combatants[opponent].power) {
            winner = msg.sender;
            loser = opponent;
        } else if (combatants[msg.sender].power < combatants[opponent].power) {
            winner = opponent;
            loser = msg.sender;
        } else {
            return; 
        }

        vault.transferTokens(loser, winner, 500);

        emit CombatResult(winner, loser, 500);
    }
}
