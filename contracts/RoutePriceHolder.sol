pragma solidity ^0.4.13;
import "./interfaces/RoutePriceHolderI.sol";
import "./Owned.sol";
import "./TollBoothHolder.sol";

contract RoutePriceHolder is TollBoothHolder, RoutePriceHolderI {

    /**
     * Called by the owner of the RoutePriceHolder.
     *     It can be used to update the price of a route, including to zero.
     *     It should roll back if the caller is not the owner of the contract.
     *     It should roll back if one of the booths is not a registered booth.
     *     It should roll back if entry and exit booths are the same.
     *     It should roll back if either booth is a 0x address.
     *     It should roll back if there is no change in price.
     *     If relevant, and only when part of TollBoothOperatorI, it will release 1 pending payment
     *       for this route.
     *     It should not roll back if the relevant pending payment is not solvable, if, for
     *       instance the vehicle has had wrongly set values in the interim.
     *     When part of TollBoothOperatorI, it should be possible to call it even when the contract
     *       is in the `true` paused state.
     * @param entryBooth The address of the entry booth of the route set.
     * @param exitBooth The address of the exit booth of the route set.
     * @param priceWeis The price in weis of the new route.
     * @return Whether the action was successful.
     * Emits LogPriceSet.
     */
    function setRoutePrice(address entryBooth,address exitBooth,uint priceWeis) public fromOwner returns(bool success) {
        
    }

    /**
     * @param entryBooth The address of the entry booth of the route.
     * @param exitBooth The address of the exit booth of the route.
     * @return priceWeis The price in weis of the route.
     *     If the route is not known or if any address is not a booth it should return 0.
     *     If the route is invalid, it should return 0.
     */
    function getRoutePrice( address entryBooth, address exitBooth) constant public returns(uint priceWeis) {
            return 0;
    }
}