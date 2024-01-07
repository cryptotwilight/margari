const iGiltContractAbi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_erc20",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "_amount",
				"type": "uint256"
			}
		],
		"name": "bondFunds",
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
			}
		],
		"name": "burnLocalisedGilt",
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
				"name": "_tGilt",
				"type": "tuple"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
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
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
		"name": "isLocalBonded",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_isLocalBonded",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
		"name": "isLocked",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_isLocked",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
		"name": "lockGilt",
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
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
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
				"name": "_tGilt",
				"type": "tuple"
			},
			{
				"internalType": "address",
				"name": "_to",
				"type": "address"
			}
		],
		"name": "mintLocalisedGilt",
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
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
		"name": "unBondFunds",
		"outputs": [
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
				"name": "_to",
				"type": "address"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_giltId",
				"type": "uint256"
			}
		],
		"name": "unlockGilt",
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
		"stateMutability": "nonpayable",
		"type": "function"
	}
]