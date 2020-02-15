pragma solidity ^0.6.0;

import "https://github.com/jschiarizzi/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721Full.sol";

contract Subscription is ERC721Full {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    uint256 price; //cost of sub created by owner. default = 0
    address owner;

    constructor() ERC721Full("GameItem", "ITM") public {
        price = 0;
        owner = msg.sender;
    }

    function mintSub(address subscriber) public payable returns (uint256) {
        require(msg.value >= price);
        _tokenIds.increment();

        _mint(subscriber, _tokenIds.current());
        //_setTokenURI(newItemId, "");

        return _tokenIds.current();
    }
    
    //allow owner to change price
    function setPrice(uint256 newPrice) public {
        require(msg.sender == owner);
        price = newPrice;
    }
}
