const iMSenderAbi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_sendId",
				"type": "uint256"
			}
		],
		"name": "getTransmittedGilt",
		"outputs": [
			{
				"components": [
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
						"name": "gilt",
						"type": "tuple"
					},
					{
						"internalType": "bytes32",
						"name": "alloProfileId",
						"type": "bytes32"
					},
					{
						"internalType": "uint256",
						"name": "projectId",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "owner",
						"type": "address"
					}
				],
				"internalType": "struct TransmittedGilt",
				"name": "_gilt",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_destinationChainId",
				"type": "uint256"
			},
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
				"internalType": "address",
				"name": "_owner",
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

export default iMSenderAbi; 