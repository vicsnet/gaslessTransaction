// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@opengsn/contracts/src/ERC2771Recipient.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";

contract VinceToken is ERC2771Context, ERC20{

// address private immutable trustedForwarder;

    constructor(address trustedForwarder) ERC20("VINCETOKEN", "VIT") ERC2771Context(trustedForwarder) {
        
    //    _trustedForwarder = trustedForwarder;
    }

    function buyToken(uint _amount) public{
        // address sender = _msgSender();
        _mint(_msgSender(), _amount * 1e18);
    }

  

    // function isTrustedForwarder(address forwarder) public view returns(bool) {
    //     return forwarder == _trustedForwarder;
    // }

    // function _msgSenders() internal view returns (address payable signer) {
    //     signer =payable(msg.sender);
    //     if (msg.data.length>=20 && isTrustedForwarder(signer)) {
    //         assembly {
    //             signer := shr(96,calldataload(sub(calldatasize(),20)))
    //         }
    //     }    
    // }

    
}

