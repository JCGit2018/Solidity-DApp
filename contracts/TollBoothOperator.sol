pragma solidity ^0.4.13;

import "./interfaces/TollBoothOperatorI.sol";
import "./DepositHolder.sol";
import "./TollBoothHolder.sol";
import "./MultiplierHolder.sol";
import "./RoutePriceHolder.sol";
import "./Pausable.sol";
import "./interfaces/RegulatedI.sol";

contract TollBoothOperator is Pausable, RoutePriceHolder, MultiplierHolder, DepositHolder, RegulatedI, TollBoothOperatorI {

    address regulatorVar;

    function TollBoothOperator(bool paused, address _regulator, uint deposit) Pausable(paused) DepositHolder(deposit) public {
        // setOwner(_regulator);
        regulatorVar = _regulator;
    }
    
    function hashSecret(bytes32 secret) constant  public returns(bytes32 hashed) {
        return secret;
    }


    /**
     * Called by the vehicle entering a road system.
     * Off-chain, the entry toll booth will open its gate up successful deposit and confirmation
     * of the vehicle identity.
     *     It should roll back when the contract is in the `true` paused state.
     *     It should roll back if `entryBooth` is not a tollBooth.
     *     It should roll back if less than deposit * multiplier was sent alongside.
     *     It should be possible for a vehicle to enter "again" before it has exited from the 
     *       previous entry.
     * @param entryBooth The declared entry booth by which the vehicle will enter the system.
     * @param exitSecretHashed A hashed secret that when solved allows the operator to pay itself.
     *   A previously used exitSecretHashed cannot be used ever again.
     * @return Whether the action was successful.
     * Emits LogRoadEntered.
     */
    function enterRoad(address entryBooth, bytes32 exitSecretHashed) public payable returns (bool success) {
        return true;
    }

    /**
     * @param exitSecretHashed The hashed secret used by the vehicle when entering the road.
     * @return The information pertaining to the entry of the vehicle.
     *     vehicle: the address of the vehicle that entered the system.
     *     entryBooth: the address of the booth the vehicle entered at.
     *     depositedWeis: how much the vehicle deposited when entering.
     * After the vehicle has exited, `depositedWeis` should be returned as `0`.
     * If no vehicles had ever entered with this hash, all values should be returned as `0`.
     */
    function getVehicleEntry(bytes32 exitSecretHashed) constant public
        returns(address vehicle, address entryBooth, uint depositedWeis) {
            return(0,0,0);
    }

    /**
     * Called by the exit booth.
     *     It should roll back when the contract is in the `true` paused state.
     *     It should roll back when the sender is not a toll booth.
     *     It should roll back if the exit is same as the entry.
     *     It should roll back if the secret does not match a hashed one.
     * @param exitSecretClear The secret given by the vehicle as it passed by the exit booth.
     * @return status:
     *   1: success, -> emits LogRoadExited
     *   2: pending oracle -> emits LogPendingPayment
     */
    function reportExitRoad(bytes32 exitSecretClear) public returns (uint status) {
        return 0;
    }

    /**
     * @param entryBooth the entry booth that has pending payments.
     * @param exitBooth the exit booth that has pending payments.
     * @return the number of payments that are pending because the price for the
     * entry-exit pair was unknown.
     */
    function getPendingPaymentCount(address entryBooth, address exitBooth) constant public returns (uint count) {
        return 0;
    }

    /**
     * Can be called by anyone. In case more than 1 payment was pending when the oracle gave a price.
     *     It should roll back when the contract is in `true` paused state.
     *     It should roll back if booths are not really booths.
     *     It should roll back if there are fewer than `count` pending payment that are solvable.
     *     It should roll back if `count` is `0`.
     * @param entryBooth the entry booth that has pending payments.
     * @param exitBooth the exit booth that has pending payments.
     * @param count the number of pending payments to clear for the exit booth.
     * @return Whether the action was successful.
     * Emits LogRoadExited as many times as count.
     */
    function clearSomePendingPayments( address entryBooth, address exitBooth, uint count) public returns (bool success) {
            return true;
    }

    /**
     * @return The amount that has been collected so far through successful payments.
     */
    function getCollectedFeesAmount() constant public returns(uint amount) {
        return 0;
    }

    /**
     * Called by the owner of the contract to withdraw all collected fees (not deposits) to date.
     *     It should roll back if any other address is calling this function.
     *     It should roll back if there is no fee to collect.
     *     It should roll back if the transfer failed.
     * @return success Whether the operation was successful.
     * Emits LogFeesCollected.
     */
    function withdrawCollectedFees()public returns(bool success) {
        return true;
    }

    function setRegulator(address newRegulator)    public returns(bool success) {
        regulatorVar = newRegulator;
        return true;
    }

    function getRegulator() constant public returns(RegulatorI regulator) {
        return RegulatorI(regulatorVar);
    }
}