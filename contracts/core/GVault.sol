// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import "../interfaces/IMVersion.sol";
import "../interfaces/IMRegister.sol";
import "../interfaces/IGVault.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GVault is IGVault, IMVersion { 

    string constant name = "G_VAULT";
    uint256 constant version = 1; 

    address constant NATIVE = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    Gilt gilt; 
    IMRegister register; 
    address immutable self;
    bool expended = false; 

    constructor(address _register, Gilt memory _gilt) { 
        gilt = _gilt;
        register = IMRegister(_register);
        self = address(this); 
    }

    function getName() pure external returns (string memory _name) {
        return name; 
    }

    function getVersion() pure external returns (uint256 _version) {
        return version; 
    }

    function getGilt() view external returns (Gilt memory _gilt){
        return gilt; 
    }

    function getErc20() view external returns (address _erc20){
        return gilt.erc20; 
    }

    function getAmountStored() view external returns (uint256 _amount){
        return IERC20(gilt.erc20).balanceOf(self);
    }

    function storeFunds() external payable returns (bool _stored){
        require(!expended, "vault expended");
        if(gilt.erc20 == NATIVE) {
            require(msg.value == gilt.amount, " NATIVE token transmission mis-match");
        }
        else {
            IERC20(gilt.erc20).transferFrom(msg.sender, self, gilt.amount);
        }
        return true; 
    }

    function releaseFunds() external returns(bool _empty){
        require(!expended, "vault expended");
        expended = true; 
        if(gilt.erc20 == NATIVE) {
            payable(msg.sender).transfer(self.balance);
        }
        else {
            IERC20(gilt.erc20).approve(msg.sender, gilt.amount);
        }
        return expended; 
    }

    function isExpended() view external returns (bool _isExpended){
        return expended; 
    }   

}