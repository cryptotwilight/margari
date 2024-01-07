const iGVaultFactoryAbi = [
	{
		"inputs": [
			{
				"components": [
					{
						"internalType": "address",
						"name": "erc20",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "amount",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "creationDate",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "chainId",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "giltContract",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					}
				],
				"internalType": "struct Gilt",
				"name": "_gilt",
				"type": "tuple"
			}
		],
		"name": "createVault",
		"outputs": [
			{
				"internalType": "address",
				"name": "_vault",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]