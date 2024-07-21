# Avalon Legends

Welcome to Avalon Legends! This project is inspired by DeFi Kingdoms and is built on the Avalanche blockchain. Avalon Legends offers an engaging blockchain-based gaming experience with features like Combating , Trading, and Exploring.

## Description

Avalon Legends consists of Smart Contracts written in Solidity, designed to replicate some key features of the DeFi Kingdoms game. Our contracts enable a rich set of functionalities, including battling, trading, and exploring, built on top of an ERC20-based token system. The Vault contract acts as an in-game bank, allowing players to manage their tokens efficiently.

## Getting Started

### Executing Program

To run this program, you can use Remix, an online Solidity IDE. Visit [Remix Ethereum](https://remix.ethereum.org/) to get started.

Download all files from the repository and add them to your Remix IDE. Begin by creating a Custom Subnet in your local network and then add that network to your MetaMask wallet for transaction execution.

### Creating Custom Subnet

1. **Install the Avalanche CLI tool**: Install the Avalanche Command Line Interface (CLI) tool to interact with the Avalanche network from your terminal. Find installation instructions in the [official documentation](https://docs.avax.network/).

2. **Create a new subnet**: Run `avalanche subnet create mySubnet` in your terminal to create a new subnet named "mySubnet" on your local machine.

3. **Select the EVM Subnet option and configure**: Choose the `SubnetEVM` option to create an EVM Subnet on your local machine.

4. **Deploy the subnet**: Run `avalanche subnet deploy mySubnet` and choose to deploy your subnet on your local network. This deploys your new EVM Subnet locally.

5. **View subnet details**: After deploying the EVM Subnet, use the displayed information to interact with the subnet and start building your smart-contract protocol.

6. **Stopping subnet**:Run `avalanche network stop` command to stop the current running subnet.

Connect to MetaMask and choose Injected provider - MetaMask in Remix IDE.

## Functionality

### ERC20
- **Minting**: Create new tokens in main balance.
- **Burning**: Remove tokens from circulation.
- **Transfer**: Send tokens between addresses.
- **Approval**: Authorization of spending of tokens by different addresses.

### Vault
- **Deposit**: Deposit tokens into the vault balance.
- **depositFor**: depositFor has a special functionality in which intial tokens are directly tranfered to vault balance.
- **Withdraw**: Withdraw tokens from the vault.
- **Balance**: Check token balance in the vault.
- **TransferTokens**: Transfer tokens within the vault.

### Combat
- **RegisterCombat**: Register for combat if the user has 500 tokens in the vault.
- **Combat**: Engage in battles where the winner gains tokens from the loser based on the power of their inventories.
- **Combatants**: Returns the powervalue of the current address.

### Trading
- **Trade**: Exchange players between users by transferring tokens through the vault.
- **playerPrices**: Retrieves the token value for each player card trading by simply entering there playerId.
- **GetAddresses**: Retrieves the explore and vault contracts addresses

### Exploring
- **Explore**: Users explore to receive players and, on the first exploration, gain 2000 tokens which will be deposited into the vault.
- **getInventory**: Retrieves inventory of the particular user by their address. The inventory consists of playerId , power and name.

## Working

1. **Deploy Contracts**: 
    - **ERC20**: Compile and deploy the `ERC20` contract first. Copy the contract address.
    - **Vault**: Deploy the `Vault` contract using the ERC20 contract address.
    - **Explore, Combat, Trading**: Deploy the remaining contracts using the necessary addresses.

2. **Perform Functions**: 
    - Use deployed contracts to mint, burn, and transfer tokens, explore new players, register for battles, and trade players.
    - Interact with the vault to manage token deposits and withdrawals.

## Authors

Contributors names and contact info:

[Samyak Jain]  
[LinkedIn](https://www.linkedin.com/in/samyak-jain-179710233/)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
