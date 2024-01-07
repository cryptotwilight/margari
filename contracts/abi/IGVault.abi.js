const iGVaultAbi = [
	{
		"inputs": [],
		"name": "getAmountStored",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getErc20",
		"outputs": [
			{
				"internalType": "address",
				"name": "_erc20",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getGilt",
		"outputs": [
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
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "isExpended",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_isExpended",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "releaseFunds",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_empty",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "storeFunds",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_stored",
				"type": "bool"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	}
]