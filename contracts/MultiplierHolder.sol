pragma solidity ^0.4.13;

import "./Owned.sol";
import "./interfaces/MultiplierHolderI.sol";

contract MultiplierHolder is Owned, MultiplierHolderI {
    mapping(uint => uint) private vehicleMultiplier;
    function MultiplierHolder() {

    }
    /**
     * Called by the owner of the TollBoothOperator.
     *   Can be used to update a value.
     *   It should roll back if the vehicle type is 0.
     *   Setting the multiplier to 0 is equivalent to removing it and is acceptable.
     *   It should roll back if the same multiplier is already set to the vehicle type.
     * @param vehicleType The type of the vehicle being set.
     * @param multiplier The multiplier to use.
     * @return Whether the action was successful.
     * Emits LogMultiplierSet.
     */
    function setMultiplier( uint vehicleType,uint multiplier) public returns(bool) {
        require(vehicleType != 0);
        require (vehicleMultiplier[vehicleType] != multiplier);
        vehicleMultiplier[vehicleType] = multiplier;
        return true;
    }

    /**
     * @param vehicleType The type of vehicle whose multiplier we want
     *     It should accept a vehicle type equal to 0.
     * @return The multiplier for this vehicle type.
     *     A 0 value indicates a non-existent multiplier.
     */
    function getMultiplier(uint vehicleType) constant public returns(uint) {
        return vehicleMultiplier[vehicleType];
    }

}