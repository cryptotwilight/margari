# margari
This is the repository for the margari project. 

## Introduction 
As decentralized forms of working become more the norm and on chain working begins to move away from being a novelty to something more concrete, the emergence of cross chain ecosystems creates a challenge to this. In short the disociation between talent and funding becomes more pronounced as a funder / sponsor or grantor may reside on one chain leveraging Allo protocol whilst the DAO or general project contributors may reside on a variety of chains introducing a complexity in accounting and fund management. 

## Why Margari 
Margari was created to enable projects leveraging the Allo Protocol to seemlessly transmit approved funds to project contributors regardless of where they reside on chain. The premise of the Margari protocol is to provide security and flexibility by leveraging the Allo Registry to maintain project security and by enabling the projects to self organise their deliverables within the context of their allocated budget. In the fund distribution phase of the project Margari shines by leveraging Chainlink CCIP to transmit (Gilts which are NFTs representing bonded funds) to foreign chains where contributors can claim/dispose/repatriate as required. Thus project contributors (e.g. your average content producer) no longer have to worry about navigating the challenging world of cross chain bridges, and irrecoverable funds etc.


## Margari Deploy Order 
To build Margari using remix the contract deployment order listed below is to be followed, after each contract is deployed it's address should be added to the registry using the addMVersion() function for automated registration: 

1. MRegister.sol - this registers all the DApp contracts enabling configuration free interconnects
2. GVaultFactory.sol - this provides instances of the GVault which is used to secure Gilt bonded funds
3. GiltContract.sol - this is an ERC721 compliant contract that enables the free movement and transfer of bonded & localised Gilts
4. MSender.sol - this sends Gilts to a foreign chain (in this case OP Goerli)
5. MReciever.sol - this recieves Gilts from a foreign chain (in this case from Aribitrum Sepolia)
6. Margari.sol - this is the core Margari contract
7. MargariStrategy.sol - this is the Margari Allo strategy used for running fund distributions to sponsered projects
8. MProjectFactory.sol - this is provides project contracts to which project members can self organise around project deliverables

Once the above contracts have been deployed the following additional 3rd Party address entries need to be made to the Margari Register:

|Name                           | Required Registry Entry Name      | Contract                                   | Chain    |
|-------------------------------|-----------------------------------|--------------------------------------------|----------|
|Allo Proxy                     | RESERVED_ALLO_CORE                | 0x1133eA7Af70876e64665ecD07C0A0476d09465a1 | 421614   |
|Allo Register                  | RESERVED_ALLO_PROFILE_REGISTER    | 0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3 | 421614   |
|Chainlink Router (Sepolia)     | RESERVED_CHAINLINK_ROUTER_CLIENT  | 0x0bf3de8c5d3e8a2b34d2beeb17abfcebaf363a59 | 11155111 |
|Chainlink Router (Arbitrum)    | RESERVED_CHAINLINK_ROUTER_CLIENT  | 0x2a9c5afb0d0e4bab2bcdae109ec4b0c4be15a165 | 421614   |

### Destination Configurations 

Additional to the above addresses the following destination configurations should be set in the Margari Register on each chain where Margari is deployed. 

#### Sepolia
["11155111","16015286601757825753","0x0bf3de8c5d3e8a2b34d2beeb17abfcebaf363a59",["0x779877A7B0D9E8603169DdbD7836e478b4624789","0x097D90c9d3E0B50Ca60e1ae45F6A81010f9FB534"],"<deployment address of MReciever contract>"]

#### Arbitrum Sepolia
["421614","3478487238524512106","0x2a9c5afb0d0e4bab2bcdae109ec4b0c4be15a165",["0xdc2CC710e42857672E7907CF474a69B63B93089f","0xE591bf0A0CF924A0674d7792db046B23CEbF5f34"],"<deployment address of MReciever contract>"]


## Deployed Contracts 
The following are the deployed contracts for Margari. These contracts interact

| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
|*Arbitrum*|    (Testnet)        |                                            |
| 421614   | MRegister.sol       | [0x6aA7c51924143Bf05851C229c7bb0fB0D19c046D](https://sepolia.arbiscan.io/address/0x6aA7c51924143Bf05851C229c7bb0fB0D19c046D) |
| 421614   | GVaultFactory.sol   | [0xaA8a63Ab079A5EF4cd5b51a95dE825D40c77ED9d](https://sepolia.arbiscan.io/address/0xaa8a63ab079a5ef4cd5b51a95de825d40c77ed9d) |
| 421614   | GiltContract.sol    | [0x4Bee91F1707DaA7Bd7BA684a52aB1bdd8Cb38944](https://sepolia.arbiscan.io/address/0x4Bee91F1707DaA7Bd7BA684a52aB1bdd8Cb38944) |
| 421614   | MSender.sol         | [0x4FE537F6eFe5C63d451e0C7F3540650005CEAe7A](https://sepolia.arbiscan.io/address/0x4FE537F6eFe5C63d451e0C7F3540650005CEAe7A) |
| 421614   | MReciever.sol       | [0x99bd0287877a957077Fcf2221512ce72aAC360Ba](https://sepolia.arbiscan.io/address/0x99bd0287877a957077fcf2221512ce72aac360ba) |        
| 421614   | Margari.sol         | [0x4e14C6f0D3E9a7327e48e397C20b2B5a15528ab4](https://sepolia.arbiscan.io/address/0x4e14C6f0D3E9a7327e48e397C20b2B5a15528ab4) |
| 421614   | MargariStrategy.sol | [0xc7E47139e0f4A90f10ce402a790B6ED0b5ce3aBd]() |
| 421614   | MProjectFactory.sol | [0x0E826F2B23f9200e9a34D3d15E7BD902cffCC600]() |
| 421614   | MargariTestToken.sol| [0x5107984C96297564eE9aDC5c77e986B41c9aD25C]() |
| 421614   | MProjectCreator.sol | []()                                           |
|          |                     |                                                |
|*Sepolia* |   (Testnet)         |                                            |
| 11155111 | MRegister.sol       | [0x261f61460c2Ca01284f1Df3664985ec9322a867B]() |
| 11155111 | GVaultFactory.sol   | [0xeCc1223fcE6cE6A5eeC9ea84Af16aC15cc7b1855]() |
| 11155111 | GiltContract.sol    | [0x2892FFbF7ad1985cB8176BEd59d8378EF8a1225D]() |
| 11155111 | MSender.sol         | [0x536936c3d3e38eC6A97585c31F5063b770Cf2EAd]() |
| 11155111 | MReciever.sol       | [0x9b8E907b2e91e8E2bDcCF30505fF7d508C190544]() |        
| 11155111 | Margari.sol         | [0x16B0975dc8B4eaDB28F2a776C8BcE499875E3Bb8]() |
| 11155111 | MargariTestToken.sol| [0x1C5A3cDd6E29D15a170fb74AB1ea257c6993bEe1]() |

*NOTE: * Margari is only is deployed on Sepolia as it is utilised for claiming Gilts only.