
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;
contract RecipientExample {

    function purchaseItem(uint256 itemId) external {
        address sender = _msgSender();
        // ... perform the purchase for sender
    }

    address immutable _trustedForwarder;
    constructor(address trustedForwarder){
        _trustedForwarder = trustedForwarder;
    }

    function isTrustedForwarder(address forwarder) public returns(bool) {
        return forwarder == _trustedForwarder;
    }

    function _msgSender() internal returns (address payable signer) {
        signer = payable(msg.sender);
        if (msg.data.length>=20 && isTrustedForwarder(signer)) {
            assembly {
                signer := shr(96,calldataload(sub(calldatasize(),20)))
            }
        }    
    }

}