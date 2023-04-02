// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@opengsn/contracts/src/ERC2771Recipient.sol";

contract TokenSwap is ERC20 {
    // IERC20 ierc20;

    // ierc20 = IERC20(0xA771Ec96dFbcaa420426188060CceDdBC89f9b66);
    constructor() ERC20("web3Token", "W3T") {
       
    }

    function buyToken(uint _amount) public{
        // _mint(msg.sender, _amount * decimals());
    }


function swapToken(uint _Amount) public returns(uint){
    require(IERC20(0xA771Ec96dFbcaa420426188060CceDdBC89f9b66).balanceOf(msg.sender) >= _Amount, "EXCESS_AMOUNT_INPUT");

    IERC20(0xA771Ec96dFbcaa420426188060CceDdBC89f9b66).transfer(address(this), _Amount);
    uint tokenUint = _Amount/2;
    _mint(msg.sender, tokenUint);

    return tokenUint;


}
    
}
