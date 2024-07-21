// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC20.sol";
import "./Vault.sol";

contract Explore {
    ERC20 public token;
    Vault public vault;
    uint256 public constant INITIAL_TOKENS = 2000;

    struct Player {
        uint256 playerId;
        uint256 power;
        string name;
    }

    mapping(address => Player[]) public inventories;
    mapping(address => bool) public hasExplored;

    event PlayerAssigned(address indexed user, uint256 playerId, uint256 power, string name);

    constructor(address tokenAddress, address vaultAddress) {
        token = ERC20(tokenAddress);
        vault = Vault(vaultAddress);
    }

    function explore() external {
        if (!hasExplored[msg.sender]) {
            token.mint(address(this), INITIAL_TOKENS);
            token.approve(address(vault), INITIAL_TOKENS);
            vault.depositFor(msg.sender, INITIAL_TOKENS);

            hasExplored[msg.sender] = true;
        }

        uint256 playerId = getRandomPlayerId();
        uint256 power = getPlayerPower(playerId);
        string memory name = getPlayerName(playerId);

        Player memory newPlayer = Player({
            playerId: playerId,
            power: power,
            name: name
        });

        inventories[msg.sender].push(newPlayer);

        emit PlayerAssigned(msg.sender, playerId, power, name);
    }

    function getInventory(address user) external view returns (Player[] memory) {
        return inventories[user];
    }

    function getRandomPlayerId() internal view returns (uint256) {
        return (uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 5) + 1;
    }

    function getPlayerPower(uint256 playerId) internal pure returns (uint256) {
        if (playerId == 1) return 1;
        if (playerId == 2) return 2;
        if (playerId == 3) return 3;
        if (playerId == 4) return 4;
        if (playerId == 5) return 5;
        return 0;
    }

    function getPlayerName(uint256 playerId) internal pure returns (string memory) {
        if (playerId == 1) return "Troop";
        if (playerId == 2) return "Healer";
        if (playerId == 3) return "Warrior";
        if (playerId == 4) return "Commander";
        if (playerId == 5) return "King";
        return "Unknown";
    }

    function removePlayer(address user, uint256 index) external {
        require(index < inventories[user].length, "Invalid index");
        for (uint256 i = index; i < inventories[user].length - 1; i++) {
            inventories[user][i] = inventories[user][i + 1];
        }
        inventories[user].pop();
    }

    function addPlayer(address user, Player memory player) external {
        inventories[user].push(player);
    }
}
