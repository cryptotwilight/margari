const iMargariAbi = [
	{
		"inputs": [],
		"name": "claimGilts",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "projectId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "giltId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "chainId",
						"type": "uint256"
					}
				],
				"internalType": "struct GiltClaim[]",
				"name": "_giltClaims",
				"type": "tuple[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_chainId",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_erc20",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			},
			{
				"internalType": "address",
				"name": "_remoteRecipient",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "_alloProfileId",
				"type": "bytes32"
			},
			{
				"internalType": "uint256",
				"name": "_projectId",
				"type": "uint256"
			}
		],
		"name": "sendFunds",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_sendId",
				"type": "uint256"
			}
		],
		"stateMutability": "payable",
		"type": "function"
	},
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
			},
			{
				"internalType": "bytes32",
				"name": "_alloProfileId",
				"type": "bytes32"
			},
			{
				"internalType": "uint256",
				"name": "_projectId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_destinationChainId",
				"type": "uint256"
			}
		],
		"name": "sendGilt",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "_sendId",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

export default iMargari; 