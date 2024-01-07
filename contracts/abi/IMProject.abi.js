const iMProjectAbi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_newBudget",
				"type": "uint256"
			}
		],
		"name": "amendBudget",
		"outputs": [
			{
				"internalType": "int256",
				"name": "_amendmentAmount",
				"type": "int256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_contributorWallet",
				"type": "address"
			}
		],
		"name": "getContributorByAddress",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "homeChain",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "wallet",
						"type": "address"
					},
					{
						"components": [
							{
								"internalType": "uint256",
								"name": "protocol",
								"type": "uint256"
							},
							{
								"internalType": "string",
								"name": "pointer",
								"type": "string"
							}
						],
						"internalType": "struct Metadata",
						"name": "metadata",
						"type": "tuple"
					}
				],
				"internalType": "struct Contributor",
				"name": "_contributor",
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
				"name": "_contributorId",
				"type": "uint256"
			}
		],
		"name": "getContributorById",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "homeChain",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "wallet",
						"type": "address"
					},
					{
						"components": [
							{
								"internalType": "uint256",
								"name": "protocol",
								"type": "uint256"
							},
							{
								"internalType": "string",
								"name": "pointer",
								"type": "string"
							}
						],
						"internalType": "struct Metadata",
						"name": "metadata",
						"type": "tuple"
					}
				],
				"internalType": "struct Contributor",
				"name": "_contributor",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getContributorIds",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "_contributorIds",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_deliverableId",
				"type": "uint256"
			}
		],
		"name": "getDeliverableById",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "projectId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "payoutAmount",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"components": [
							{
								"internalType": "uint256",
								"name": "protocol",
								"type": "uint256"
							},
							{
								"internalType": "string",
								"name": "pointer",
								"type": "string"
							}
						],
						"internalType": "struct Metadata",
						"name": "metadata",
						"type": "tuple"
					},
					{
						"internalType": "enum DeliverableStatus",
						"name": "deliverableStatus",
						"type": "uint8"
					},
					{
						"internalType": "enum PayoutStatus",
						"name": "payoutStatus",
						"type": "uint8"
					}
				],
				"internalType": "struct Deliverable",
				"name": "_deliverable",
				"type": "tuple"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getPaymentDirectives",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "id",
						"type": "uint256"
					},
					{
						"components": [
							{
								"internalType": "uint256",
								"name": "id",
								"type": "uint256"
							},
							{
								"internalType": "uint256",
								"name": "homeChain",
								"type": "uint256"
							},
							{
								"internalType": "address",
								"name": "wallet",
								"type": "address"
							},
							{
								"components": [
									{
										"internalType": "uint256",
										"name": "protocol",
										"type": "uint256"
									},
									{
										"internalType": "string",
										"name": "pointer",
										"type": "string"
									}
								],
								"internalType": "struct Metadata",
								"name": "metadata",
								"type": "tuple"
							}
						],
						"internalType": "struct Contributor",
						"name": "contributor",
						"type": "tuple"
					},
					{
						"internalType": "uint256",
						"name": "projectId",
						"type": "uint256"
					},
					{
						"internalType": "bytes32",
						"name": "alloProfileId",
						"type": "bytes32"
					},
					{
						"internalType": "uint256",
						"name": "deliverableId",
						"type": "uint256"
					},
					{
						"internalType": "uint256",
						"name": "amount",
						"type": "uint256"
					},
					{
						"internalType": "address",
						"name": "erc20",
						"type": "address"
					}
				],
				"internalType": "struct PaymentDirective[]",
				"name": "_directives",
				"type": "tuple[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getProjectDescriptor",
		"outputs": [
			{
				"components": [
					{
						"internalType": "uint256",
						"name": "projectId",
						"type": "uint256"
					},
					{
						"internalType": "string",
						"name": "name",
						"type": "string"
					},
					{
						"internalType": "uint256",
						"name": "alloPoolId",
						"type": "uint256"
					},
					{
						"internalType": "bytes32",
						"name": "alloProfileId",
						"type": "bytes32"
					},
					{
						"internalType": "address",
						"name": "payoutCurrency",
						"type": "address"
					},
					{
						"internalType": "uint256",
						"name": "budget",
						"type": "uint256"
					},
					{
						"internalType": "uint256[]",
						"name": "deliverableIds",
						"type": "uint256[]"
					},
					{
						"internalType": "address[]",
						"name": "contributors",
						"type": "address[]"
					}
				],
				"internalType": "struct Project",
				"name": "_project",
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
				"name": "_deliverableId",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "_newContributorId",
				"type": "uint256"
			}
		],
		"name": "reAssignDeliverable",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_updated",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_deliverableId",
				"type": "uint256"
			}
		],
		"name": "submitDeliverable",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_submitted",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_deliverableId",
				"type": "uint256"
			},
			{
				"internalType": "enum PayoutStatus",
				"name": "_status",
				"type": "uint8"
			}
		],
		"name": "updatePayoutStatus",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_updated",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

export default iMProjectAbi; 