// SPDX-License-Identifier: APACHE 2.0
pragma solidity ^0.8.23;

struct ProjectFinancials{
    address project; 
    uint256 allocation; 
    uint256 remainingAllocation; 
    uint256 totalPaidOut;
}

interface IMargariAlloStrategy { 

    function getProjectFinancials(address _project) view external returns (ProjectFinancials memory _financials);

    function getProjects() view external returns (address [] memory _projects);

}