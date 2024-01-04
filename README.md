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

|Name                           | Required Registry Entry Name      | Contract                                   | Chain  |
|-------------------------------|-----------------------------------|--------------------------------------------|--------|
|Allo Proxy                     | RESERVED_ALLO_CORE                | 0x1133eA7Af70876e64665ecD07C0A0476d09465a1 | 421614 |
|Allo Register                  | RESERVED_ALLO_PROFILE_REGISTER    | 0x4AAcca72145e1dF2aeC137E1f3C5E3D75DB8b5f3 | 421614 |
|Chainlink Router (Optimism)    | RESERVED_CHAINLINK_ROUTER_CLIENT  | 0xcc5a0b910d9e9504a7561934bed294c51285a78d | 420    |
|Chainlink Router (Arbitrum)    | RESERVED_CHAINLINK_ROUTER_CLIENT  | 0x2a9c5afb0d0e4bab2bcdae109ec4b0c4be15a165 | 421614 |

### Destination Configurations 

Additional to the above addresses the following destination configurations should be set in the Margari Register on each chain where Margari is deployed. 

#### OP Goerli
["420","2664363617261496610","0xcc5a0b910d9e9504a7561934bed294c51285a78d",["0xb1D4538B4571d411F07960EF2838Ce337FE1E80E","0xE591bf0A0CF924A0674d7792db046B23CEbF5f34"],"<deployment address of MReciever contract>"]

#### Arbitrum Sepolia
["421614","3478487238524512106","0x2a9c5afb0d0e4bab2bcdae109ec4b0c4be15a165",["0xdc2CC710e42857672E7907CF474a69B63B93089f","0xE591bf0A0CF924A0674d7792db046B23CEbF5f34"],"<deployment address of MReciever contract>"]


## Deployed Contracts 

| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
|*Arbitrum*|    (Testnet)        |                                            |
| 421614   | MRegister.sol       | 0xC6C74d29f3FcC18DD3d5F394ec19b2516225400E |
| 421614   | GVaultFactory.sol   | 0x6B6AD904CC3518FBeD1A86fFddC9d24d67AbD04B |
| 421614   | GiltContract.sol    | 0x536936c3d3e38eC6A97585c31F5063b770Cf2EAd |
| 421614   | MSender.sol         | 0x864CC382dd8C6047032D297a1bcFa13868F30AB3 |
| 421614   | MReciever.sol       | 0x6141b27fB5c0038bA0a194077db5186baFCb0f9a |        
| 421614   | Margari.sol         | 0xBE3024BAAEB9cD790947A92E6517E13717c673a5 |
| 421614   | MargariStrategy.sol | 0x79193FF8b91E3f08a5731c28FEC74190390DeF61 |
| 421614   | MProjectFactory.sol | 0xDF40e5db444289DE142286b9ee7076D9Aa2D92Dc |
|          |                     |                                            |
|*Optimism*|   (Testnet)         |                                            |
| 11155111 | MRegister.sol       | 0x261f61460c2Ca01284f1Df3664985ec9322a867B |
| 11155111 | GVaultFactory.sol   |                                            |
| 11155111 | GiltContract.sol    |                                            |
| 11155111 | MSender.sol         |                                            |
| 11155111 | MReciever.sol       |                                            |        
| 11155111 | Margari.sol         |                                            |
