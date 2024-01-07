// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

import {Gilt, TransmittedGilt} from "./IMStructs.sol";

interface IGiltContract { 

    function getGilt(uint256 _giltId) view external returns (Gilt memory _gilt);


    // only local gilts are bonded locally
    function isLocalBonded(uint256 _giltId) view external returns (bool _isLocalBonded);

    function bondFunds(address _erc20, uint256 _amount) external payable returns (Gilt memory _gilt);

    function unBondFunds(uint256 _giltId) external returns (address _erc20, uint256 _amount, address _to);
   
    // Transmitted Gilts are minted to the local Gilt Contract (they cannot be unbonded locally) 
    function mintLocalisedGilt(TransmittedGilt memory _tGilt, address _to) external returns (Gilt memory _gilt);

    function burnLocalisedGilt(Gilt memory _gilt) external returns (TransmittedGilt memory _tGilt);

    // Bonded Gilts are locked on the local chain in preparation for transit
    function isLocked(uint256 _giltId) view external returns (bool _isLocked);

    function lockGilt(uint256 _giltId) external returns (Gilt memory _gilt);

    function unlockGilt(uint256 _giltId) external returns (Gilt memory _gilt);

}