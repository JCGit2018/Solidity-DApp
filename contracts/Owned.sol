pragma solidity ^0.4.13;

import "./interfaces/OwnedI.sol";

contract Owned is OwnedI {

    address private owner;

    function Owned() public {
        owner = msg.sender;
    }
    /**
     * Sets the new owner for this contract.
     *   - only the current owner can call this function
     *   - only a new address can be accepted
     *   - only a non-0 address can be accepted
     * @param newOwner The new owner of the contract
     * @return Whether the action was successful.
     * Emits LogOwnerSet.
     */
    function setOwner(address newOwner) public fromOwner returns(bool success) {
        require(newOwner != owner);
        require(newOwner != 0);
        LogOwnerSet(owner, newOwner);
        owner = newOwner;
        return true;
    }

    /**
     * @return The owner of this contract.
     */
    function getOwner() public constant returns(address) {
        return owner;
    }

    modifier fromOwner {
        require(msg.sender == owner);
        _;
    }

}