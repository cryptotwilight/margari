const iMRegisterAbi = [
	{
		"inputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"name": "getAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getChainId",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_chainId",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_chainId",
				"type": "uint256"
			}
		],
		"name": "getDestinationConfig",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "chainId",
						"type": "uint256"
					},
					{
						"internalType": "uint64",
						"name": "ccipChainSelector",
						"type": "uint64"
					},
					{
						"internalType": "address",
						"name": "routerAddress",
						"type": "address"
					},
					{
						"internalType": "address[]",
						"name": "feeTokens",
						"type": "address[]"
					},
					{
						"internalType": "address",
						"name": "giltReciever",
						"type": "address"
					}
				],
				"internalType": "struct DestinationConfig",
				"name": "_dConfig",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_address",
				"type": "address"
			}
		],
		"name": "getName",
		"outputs": [
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

export default iMRegisterAbi; 