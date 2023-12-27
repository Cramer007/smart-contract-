// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Artwork {
    address public owner;
    address public ActualBuyer;
    address public FirstIntermediate;
    uint256 public Rate1;
    address public Intermediate2;
    uint256 public Rate2;
    uint256 public price;
    bool public Sold;
    string public sentence1;
    string public sentence2;
    string public sentence3;
    string public nameTab;
    string public dimensions;
    string public artsType;
    string public description;
    string public autor;
    uint256 public SellingDate;

    event SellingArtwork (address buyer, address seller, address interm, uint256 price);

    constructor() {
        owner = msg.sender;
        ActualBuyer = address(0);
        FirstIntermediate = address(0);
        Rate1 = 0;
        Intermediate2 = address(0);
        Rate2 = 0;
        price = 50 ether;
        Sold = false;

        sentence1 = "Only the owner can modify.";
        sentence2 = "Already sold.";
        sentence3 = "The price does not match.";
        nameTab = "Aurore";
        dimensions = "116x81";
        artsType = "abstract";
        autor = "lumbroso";
        description = "acrylique et encre reverse gravity";
        SellingDate = block.timestamp;
    }

    modifier OnlyTheOwner() {
        require(msg.sender == owner, sentence1);
        _;
    }

    modifier isNotSold() {
        require(!Sold, sentence2);
        _;
    }

    function buyArtwork(
        address _intermediate1, uint256 _rate1,
        address _intermediate2, uint256 _rate2
    ) public payable isNotSold {
        require(!Sold, "The work has already been sold.");
        require(msg.value == price, "The amount sent does not correspond to the price.");
        require(_intermediate1 != address(0), "The FirstIntermediate address cannot be zero.");
        require(_rate1 <= 100, "The percentage of FirstIntermediate cannot exceed 100.");
        require(_intermediate2 != address(0), "The address of Intermediate2 cannot be zero.");
        require(_rate2 <= 100, "The percentage of Intermediate2 cannot exceed 100.");

        // Save old owner before changing ownership
        address OldOwner = owner;

        // Calculation of the amount for intermediary1 and the amount for intermediary2
        uint256 accountIntermediate1 = (msg.value * _rate1) / 100;
        uint256 accountIntermediate2 = (msg.value * _rate2) / 100;

        // Calculation of the remaining amount
        uint256 RemainingAccount = msg.value - accountIntermediate1 - accountIntermediate2;

        // Calculation of transaction fees (0%)
        //uint256 fraisTransaction = (msg.value * 0) / 100;

        // Update state variables
        Sold = true;
        ActualBuyer = msg.sender;  // The current buyer becomes the new owner
        FirstIntermediate = _intermediate1;
        Rate1 = _rate1;
        Intermediate2 = _intermediate2;
        Rate2 = _rate2;
        
        // Transfer funds to intermediaries
        payable(FirstIntermediate).transfer(accountIntermediate1);
        payable(Intermediate2).transfer(accountIntermediate2);

        // Transfer transaction fees
        //payable(0xd4b552d722Fd565d0D2268e50f0239DE2fCA7B5d).transfer(fraisTransaction);

        // Transfer the remainder to the previous owner
        payable(OldOwner).transfer(RemainingAccount);

        // Emit event after updating state variables
        emit SellingArtwork (msg.sender, OldOwner, FirstIntermediate, accountIntermediate1);
        emit SellingArtwork (msg.sender, OldOwner, Intermediate2, accountIntermediate2);
    }

    function NewSell (uint256 newPrice) public OnlyTheOwner {
        require(Sold, "The artwork must have been sold to be relisted.");
        Sold = false;
        price = newPrice;  // Change in price upon resale
        ActualBuyer = address(0);  // Resetting current buyer
    }
}