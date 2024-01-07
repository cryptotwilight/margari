const iMProjectFactoryAbi = [
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "_alloProfileId",
				"type": "bytes32"
			},
			{
				"internalType": "uint256",
				"name": "_alloPoolId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			},
			{
				"internalType": "uint256",
				"name": "_budget",
				"type": "uint256"
			}
		],
		"name": "createProject",
		"outputs": [
			{
				"internalType": "address",
				"name": "_project",
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
				"name": "_alloPoolId",
				"type": "uint256"
			},
			{
				"internalType": "string",
				"name": "_name",
				"type": "string"
			}
		],
		"name": "getProject",
		"outputs": [
			{
				"internalType": "address",
				"name": "_project",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]

export default iMProjectFactoryAbi; 