pragma solidity ^0.4.25;
import "github.com/provable-things/ethereum-api/provableAPI_0.4.25.sol";
contract SimpleOraclizeContract is usingProvable {
    
    string public BTCUSDT;
    event LogConstructorInitiated(string nextStep);
    event LogPriceUpdated(string price);
    event LogNewOraclizeQuery(string description);
    
    constructor() public payable {
       emit LogConstructorInitiated("Constructor was initiated. Call 'updatePrice()' to send the Oraclize Query.");
       updatePrice(); 
    }
    function __callback(string result) public {
        if (msg.sender != provable_cbAddress()) revert();
        emit LogPriceUpdated(result);
        BTCUSDT = result;
    }
    function updatePrice()public payable {
        if (provable_getPrice("URL") > address(this).balance) {
            emit LogNewOraclizeQuery("Oraclize query was NOT sent, please add some ETH to cover for the query fee");
        } else {
            emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer..");
            provable_query("URL", "json(https://api.binance.com/api/v3/avgPrice?symbol=BTCUSDT).price"); 
        } 
    }
}

