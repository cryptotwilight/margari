const iMRecieverAbi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_claimant",
				"type": "address"
			}
		],
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
				"name": "giltClaims",
				"type": "tuple[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]

export default iMRecieverAbi; 