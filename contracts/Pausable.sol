pragma solidity ^0.4.13;

import "./Owned.sol";
import "./interfaces/PausableI.sol";

contract Pausable is Owned, PausableI {

    bool _isPaused;
    
    function Pausable(bool isPaused) {
        _isPaused = isPaused;
    }

    /**
     * Sets the new paused state for this contract.
     *   - only the current owner of this contract can call this function.
     *   - only a state different from the current one can be passed.
     * @param newState The new desired "paused" state of the contract.
     * @return Whether the action was successful.
     * Emits LogPausedSet.
     */
    function setPaused(bool newState) fromOwner returns(bool success) {
        require(_isPaused != newState);
        _isPaused = newState;
        LogPausedSet(getOwner(), newState);
        return true;
    }

    /**
     * @return Whether the contract is indeed paused.
     */
    function isPaused() constant returns(bool isIndeed) {
        return _isPaused;
    }

    modifier whenPause {
        require(!_isPaused);
        _;
    }

    modifier whenNotPaused {
        require(_isPaused);
        _;
    }
}