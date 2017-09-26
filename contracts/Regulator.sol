pragma solidity ^0.4.13;

import "./Owned.sol";
import "./interfaces/RegulatorI.sol";
import "./TollBoothOperator.sol";

contract Regulator is Owned, RegulatorI {

    uint vehicleType;
    address vehicle;
    mapping(address => uint) vehicles;
    mapping(address=>TollBoothOperator) tollBoothOperators;

    function Regulator() {

    }

    function setVehicleType(address vehicle, uint vehicleType) public fromOwner returns(bool success) {
            vehicles[vehicle] = vehicleType;
            return true;
    }

    /**
     * @param vehicle The address of the registered vehicle.
     * @return The VehicleType of the vehicle whose address was passed. 0 means it is not
     *   a registered vehicle.
     */
    function getVehicleType(address vehicle) constant public returns(uint vehicleType) {
        return vehicles[vehicle];
    }

    /**
     * Called by the owner of the regulator to deploy a new TollBoothOperator onto the network.
     *     It should start the TollBoothOperator in the `true` paused state.
     *     It should not accept as rightful owner the current owner of the regulator.
     * @param owner The rightful owner of the newly deployed TollBoothOperator.
     * @param deposit The initial value of the TollBoothOperator deposit.
     * @return The address of the newly deployed TollBoothOperator.
     * Emits LogTollBoothOperatorCreated.
     */
    function createNewOperator(address owner, uint deposit) public fromOwner returns(address newOperator) {
        require(getOwner() != owner);
        TollBoothOperator t = new TollBoothOperator(true, this, deposit);
        t.setOwner(owner);
        tollBoothOperators[t] = t;
        LogTollBoothOperatorCreated(msg.sender, t, owner, deposit);
        return t;
    }

    /**
     * Called by the owner of the regulator to remove a previously deployed TollBoothOperator from
     * the list of approved operators.
     *     It should not accept if the operator is unknown.
     * @param operator The address of the contract to remove.
     * @return Whether the action was successful.
     * Emits LogTollBoothOperatorRemoved.
     */
    function removeOperator(address operator) public fromOwner returns(bool success) {
        delete tollBoothOperators[operator];
        LogTollBoothOperatorRemoved(getOwner(), operator);
        return true;
    }

    /**
     * @param operator The address of the TollBoothOperator to test.
     * @return Whether the TollBoothOperator is indeed approved.
     */
    function isOperator(address operator) constant public returns(bool indeed) {
        if ( operator == 0x0) {
            return false;
        }
        return tollBoothOperators[operator] == operator;
    }
}