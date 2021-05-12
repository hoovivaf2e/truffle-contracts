pragma solidity >= 0.5.0 < 0.6.0;
import "github.com/provable-things/ethereum-api/provableAPI_0.5.sol";
contract randomNumber is usingProvable {
    uint public random_num;
    event LogNewRandomNumber(string result);
    event LogNewProvableQuery(string description);
    function __callback(string memory result) public {
        require(msg.sender == provable_cbAddress());
        emit LogNewRandomNumber(result);
        random_num = parseInt(result); 
    }
    function update() public payable {
        emit LogNewProvableQuery("Provable query was sent, waiting for a response...");
        provable_query("WolframAlpha", "random number between 0 and 1000");
    }
}
