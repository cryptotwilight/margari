// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

import "../interfaces/IMVersion.sol";

contract MargariTestToken is ERC20, ERC20Burnable, Ownable, ERC20Permit, IMVersion {

    string constant nme = "MARGARI_TEST_CRYPTO_TOKEN";
    uint256 constant version = 1; 

    uint256 amount = 10000000000000000000000; 
    uint256 delay = 24*60*60; 

    mapping(address=>bool) hasMinted; 
    mapping(address=>uint256) lastMintedByAddress; 

    constructor(address initialOwner)
        ERC20("Margari Test Token v1", "MGTTv1")
        Ownable(initialOwner)
        ERC20Permit("Margari Test Token Sepolia")
    {}

    function mint(address to) public  {
        if(hasMinted[msg.sender]) {
            require(block.timestamp - lastMintedByAddress[msg.sender] >= delay,"still in cool down");
        }
        _mint(to, amount);
    }

    function getName() pure external returns (string memory _name){
        return nme; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function setDelay(uint256 _delay) onlyOwner external returns (uint256 _newDelay) {
        delay = _delay;
        return delay;  
    }

    function setAmount(uint256 _amount) onlyOwner external returns (uint256 _newAmount) {
        amount = _amount; 
        return amount; 
    }
}
