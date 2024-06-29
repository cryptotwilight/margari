# margari
This is the repository for the margari project. 

## Introduction 
As decentralized forms of working become more the norm and on chain working begins to move away from being a novelty to something more concrete, the emergence of cross chain ecosystems creates a challenge to this. In short the disociation between talent and funding becomes more pronounced as a funder / sponsor or grantor may reside on one chain leveraging Allo protocol whilst the DAO or general project contributors may reside on a variety of chains introducing a complexity in accounting and fund management. 

## Why Margari 
Margari was created to enable projects leveraging the Allo Protocol to seemlessly transmit approved funds to project contributors regardless of where they reside on chain. The premise of the Margari protocol is to provide security and flexibility by leveraging the Allo Registry to maintain project security and by enabling the projects to self organise their deliverables within the context of their allocated budget. In the fund distribution phase of the project Margari shines by leveraging Chainlink CCIP to transmit (Gilts which are NFTs representing bonded funds) to foreign chains where contributors can claim/dispose/repatriate as required. Thus project contributors (e.g. your average content producer) no longer have to worry about navigating the challenging world of cross chain bridges, and irrecoverable funds etc.

## To Try Out 
To try out Margari you need to go to the following link below: 

There you will need to 

1. create an organisational profile 
2. Create and fund a grant funding pool for your organisational profile 
3. Create a project with a budget that is drawn from the funding pool i.e. your project pool can be all or some of the funding pool. 
4. You then need to add 2 Contributors to your project.
    4a. One Contributor should be local to Arbitrum Sepolia (testnet) 
    4b. One Contributor should be local to Sepolia (testnet)
5. You then need to add 20 Deliverables to your project one assigned to each of your Contributors created in Step 4. 
6. Each Contributor then needs to submit their deliverable
7. You then need to trigger distribute on your Allo Profile 
    -> This will trigger automated funds distribution to each of your contributors
    -> Local chain (Arbitrum Sepolia) contributors will be paid directly 
    -> Remote chain (Sepolia) contributors will recieve a Gilt claimable on their local chain from Margari 






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
The format for the destination configuration *tuple* that needs to be set on the IMRegister.sol contract is shown below: 
["${chain id}", "${Chainlink Destination Selector}","${Chainlink Router Contract}",["${Accepted Chainlink Payment Token}",...], "${deployment address of MReciever contract}"]



|Chain Name    | Chain Id | CCIP Chain Selector  | CCIP Router Addresss                       | Fee Token Addresses | Margari Gilt Reciever Address |
|--------------|----------|----------------------|--------------------------------------------|---------------------|-------------------------------|
|Base Sepolia  | 84532    | 10344971235874465080 | 0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93 | 0xE4aB69C077896252FAFBD49EFD26B5D171A32410, 0x4200000000000000000000000000000000000006,0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE | 0x7bc1e292ce4130f300a5faf66bf6c3064527c741 |
|OP Sepolia    | 11155420 | 5224473277236331295  | 0x114A20A10b43D4115e5aeef7345a1A71d2a60C57 | 0xE4aB69C077896252FAFBD49EFD26B5D171A32410, 0x4200000000000000000000000000000000000006,0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE | 0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D |
|Gnosis Chaido | 10200    | 8871595565390010547  | 0x19b1bac554111517831ACadc0FD119D23Bb14391 | 0xDCA67FD8324990792C0bfaE95903B8A64097754F, 0x18c8a7ec7897177E4529065a7E7B0878358B3BfF,0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE | 0xeB955fDF00A445c39DE95d5A98CADa03da0904FD | 
|Sepolia       | 11155111 | 16015286601757825753 | 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59 | 0x779877A7B0D9E8603169DdbD7836e478b4624789, 0x097D90c9d3E0B50Ca60e1ae45F6A81010f9FB534,0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE | 0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5 |  

#### Configuration Objects

**Base Sepolia** ["84532","10344971235874465080","0xD3b06cEbF099CE7DA4AcCf578aaebFDBd6e88a93",["0xE4aB69C077896252FAFBD49EFD26B5D171A32410","0x4200000000000000000000000000000000000006","0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"],"0x7bc1e292ce4130f300a5faf66bf6c3064527c741"]

**OP Sepolia** ["11155420","5224473277236331295","0x114A20A10b43D4115e5aeef7345a1A71d2a60C57",["0xE4aB69C077896252FAFBD49EFD26B5D171A32410","0x4200000000000000000000000000000000000006","0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"],"0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D"]

**Gnosis Chaido** ["10200","8871595565390010547","0x19b1bac554111517831ACadc0FD119D23Bb14391",["0xDCA67FD8324990792C0bfaE95903B8A64097754F","0x18c8a7ec7897177E4529065a7E7B0878358B3BfF","0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"],"0xeB955fDF00A445c39DE95d5A98CADa03da0904FD"]

**Sepolia** ["11155111","16015286601757825753","0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59",["0x779877A7B0D9E8603169DdbD7836e478b4624789","0x097D90c9d3E0B50Ca60e1ae45F6A81010f9FB534","0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE"],"0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5"]

## Deployed Contracts 
The following are the deployed contracts for Margari. These contracts interact

| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
|*Arbitrum*|    (Testnet)        |                                            |
| 421614   | MRegister.sol       | [0x042B1527ea730bA621F3e005fbfD4C5e34d59ad8](https://sepolia.arbiscan.io/address/0x042B1527ea730bA621F3e005fbfD4C5e34d59ad8) |
| 421614   | GVaultFactory.sol   | [0x970AaE923695f2697aC8A86569D79a5190c0C3a8](https://sepolia.arbiscan.io/address/0x970AaE923695f2697aC8A86569D79a5190c0C3a8) |
| 421614   | GiltContract.sol    | [0x7338c3dEF4db3968E1d6D3d4290Fb402768b4a14](https://sepolia.arbiscan.io/address/0x7338c3dEF4db3968E1d6D3d4290Fb402768b4a14) |
| 421614   | MSender.sol         | [0x901c5E137567Fc5213665a46cC79f43af97d3f4A](https://sepolia.arbiscan.io/address/0x901c5E137567Fc5213665a46cC79f43af97d3f4A) |
| 421614   | MReciever.sol       | [0xC0BDf2e759513745e9Fe74b939f92C661b4135a0](https://sepolia.arbiscan.io/address/0xC0BDf2e759513745e9Fe74b939f92C661b4135a0) |        
| 421614   | Margari.sol         | [0xe28f2543Ac730Cd590633081153B655ad68AF2b1](https://sepolia.arbiscan.io/address/0xe28f2543Ac730Cd590633081153B655ad68AF2b1) |
| 421614   | MStrategyFactory.sol | [0xF4588126a648E55E0073B5cb378AFd8d392f55E5](https://sepolia.arbiscan.io/address/0xF4588126a648E55E0073B5cb378AFd8d392f55E5) |
| 421614   | MProjectFactory.sol | [0x6d732665fE1b1FD497e8B7E7bBfD7903AE38289B](https://sepolia.arbiscan.io/address/0x6d732665fE1b1FD497e8B7E7bBfD7903AE38289B) |
| 421614   | MargariTestToken.sol| [0x5107984C96297564eE9aDC5c77e986B41c9aD25C](https://sepolia.arbiscan.io/address/0x5107984C96297564eE9aDC5c77e986B41c9aD25C) |
| 421614   | MProjectManager.sol | [0x2e2eBFFA0077f7fb893AC592664404af03A301a9](https://sepolia.arbiscan.io/address/0x2e2eBFFA0077f7fb893AC592664404af03A301a9)                                           |


## Destinations
| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
|*Sepolia* |   (Testnet)         |                                            |
| 11155111 | MRegister.sol       | [0x547E3994Cb80D773B9CC701b2D7867Acb016310f](https://sepolia.etherscan.io/address/0x547E3994Cb80D773B9CC701b2D7867Acb016310f) |
| 11155111 | GVaultFactory.sol   | [0xAE395747B112AFC3C02E22Da40e78948A551A03e](https://sepolia.etherscan.io/address/0xAE395747B112AFC3C02E22Da40e78948A551A03e) |
| 11155111 | GiltContract.sol    | [0x73c464a38C9EdCeC85b6fdF7F78A57188C6E226e](https://sepolia.etherscan.io/address/0x73c464a38C9EdCeC85b6fdF7F78A57188C6E226e) |
| 11155111 | MSender.sol         | [0xC81aB838A71E14504295eCAa4Bcbd6179993148E](https://sepolia.etherscan.io/address/0xC81aB838A71E14504295eCAa4Bcbd6179993148E) |
| 11155111 | MReciever.sol       | [0x7bc1e292ce4130f300a5faf66bf6c3064527c741](https://sepolia.etherscan.io/address/0x7bc1e292ce4130f300a5faf66bf6c3064527c741) |        
| 11155111 | Margari.sol         | [0x404431A5e61Aed2352173Af68f19C768F84904ee](https://sepolia.etherscan.io/address/0x404431A5e61Aed2352173Af68f19C768F84904ee) |
| 11155111 | MargariTestToken.sol| [0xEd26c5374fCa573c15b678423A5eb07584ba07E1](https://sepolia.etherscan.io/address/0xEd26c5374fCa573c15b678423A5eb07584ba07E1) |


|*Base Sepolia* |   (Testnet)         |                                            |
| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
| 84532 | MRegister.sol       | [0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C](https://sepolia.basescan.org/address/0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C) |
| 84532 | GVaultFactory.sol   | [0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2](https://sepolia.basescan.org/address/0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2) |
| 84532 | GiltContract.sol    | [0x47B7A70883F1F63572171Ed6b567C2c27d47815F](https://sepolia.basescan.org/address/0x47B7A70883F1F63572171Ed6b567C2c27d47815F) |
| 84532 | MSender.sol         | [0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA](https://sepolia.basescan.org/address/0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA) |
| 84532 | MReciever.sol       | [0x7bc1e292ce4130f300a5faf66bf6c3064527c741](https://sepolia.basescan.org/address/0x7bc1e292ce4130f300a5faf66bf6c3064527c741) |        
| 84532 | Margari.sol         | [0x6fc6E8eEab7896D500f2D53cA4e3e12DBB8E92f3](https://sepolia.basescan.org/address/0x6fc6E8eEab7896D500f2D53cA4e3e12DBB8E92f3) |
| 84532 | MargariTestToken.sol| [0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5](https://sepolia.basescan.org/address/0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5) |


|*Gnosis Chaido Testnet* |   (Testnet)         |                                            |
| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
| 10200 | MRegister.sol       | [0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C](https://gnosis-chiado.blockscout.com/address/0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C) |
| 10200 | GVaultFactory.sol   | [0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2](https://gnosis-chiado.blockscout.com/address/0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2) |
| 10200 | GiltContract.sol    | [0x47B7A70883F1F63572171Ed6b567C2c27d47815F](https://gnosis-chiado.blockscout.com/address/0x47B7A70883F1F63572171Ed6b567C2c27d47815F) |
| 10200 | MSender.sol         | [0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA](https://gnosis-chiado.blockscout.com/address/0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA) |
| 10200 | MReciever.sol       | [0xeB955fDF00A445c39DE95d5A98CADa03da0904FD](https://gnosis-chiado.blockscout.com/address/0xeB955fDF00A445c39DE95d5A98CADa03da0904FD) |        
| 10200 | Margari.sol         | [0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5](https://gnosis-chiado.blockscout.com/address/0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5) |
| 10200 | MargariTestToken.sol| [0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D](https://gnosis-chiado.blockscout.com/address/0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D) |


|*OP Sepolia* |   (Testnet)         |                                            |
| Chain    | Contract            | Address                                    | 
|----------|---------------------|--------------------------------------------|
| 11155420 | MRegister.sol       | [0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C](https://sepolia-optimism.etherscan.io/address/0x24f38d0d2eF787c45FE62a1C9BE1711d01c5b83C) |
| 11155420 | GVaultFactory.sol   | [0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2](https://sepolia-optimism.etherscan.io/address/0x3aA2b4A9B705Afb984FC679A59AA690D410B91B2) |
| 11155420 | GiltContract.sol    | [0x47B7A70883F1F63572171Ed6b567C2c27d47815F](https://sepolia-optimism.etherscan.io/address/0x47B7A70883F1F63572171Ed6b567C2c27d47815F) |
| 11155420 | MSender.sol         | [0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA](https://sepolia-optimism.etherscan.io/address/0xE92dfDf9E5a38038e09260caa13Cb3aE1d0e4aBA) |
| 11155420 | MReciever.sol       | [0xeB955fDF00A445c39DE95d5A98CADa03da0904FD](https://sepolia-optimism.etherscan.io/address/0xeB955fDF00A445c39DE95d5A98CADa03da0904FD) |        
| 11155420 | Margari.sol         | [0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5](https://sepolia-optimism.etherscan.io/address/0x5Bfe699166CE0B76AEB29F7B0f7C0c79703D18D5) |
| 11155420 | MargariTestToken.sol| [0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D](https://sepolia-optimism.etherscan.io/address/0x80B4B22f31003e5F6E45bbe8DeEBe5540ABa940D) |

**NOTE:** Margari is deployed on Base Sepolia, Gnosis Chaido, OP Sepolia, and Sepolia for claiming Gilts only.