the code is in the continuity of my presentation on the smart contract that i presented earlier in the semester.
this READ.ME is the description of the code but it is also explain in the video i made. i don't know if you can see the video so...

description :
This Ethereum smart contract, written in Solidity, is designed for managing the sale and resale of artworks. It incorporates features like intermediary management, commission calculations, and ownership transfer.

features:
ownership management: Tracks the current owner of the artwork.
artwork sale: Facilitates the purchase of artworks, handling payments and intermediary commissions.
resale: Allows the owner to relist the artwork for sale.

how it works :
initialisation: Upon contract creation, the artwork is registered with its details (name, dimensions, type, etc.).
Purchase: A buyer can purchase the artwork adhering to the set price and specifying intermediaries and their commissions.
ownership transfer: After the purchase, the ownership of the artwork is transferred to the buyer.

developpement :
To deploy this contract, you will need:
- Node.js and npm
- Truffle or another Solidity development framework
- An Ethereum wallet (like MetaMask)

To interact with the contract:
Deploy: Use Truffle to deploy the contract to your chosen Ethereum network.
Interract: Use a Web3 interface to interact with the contract.


- `SellingArtwork`: Triggered when an artwork is sold.

Functions: 
- `buyArtwork`: Facilitates the purchase of the artwork.
- `NewSell`: Allows relisting the artwork for sale.

The `OnlyTheOwner` and `isNotSold` modifiers ensure that only authorized actors can perform certain actions.
