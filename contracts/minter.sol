// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract Minter is ERC721 {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("MidnightNFT", "Midnight Defender") {
    console.log("This is my NFT contract. Woah!");
  }

  // A function our user will hit to get their NFT.
  function mintNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    //https://jsonkeeper.com/b/BFLQ
    // Return the NFT's metadata
    tokenURI(newItemId);
    // tokenURI(newItemId, "https://jsonkeeper.com/b/BFLQ");

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }

  // Set the NFT's metadata
  function tokenURI(uint256 _tokenId) public view override returns (string memory) {
     require(_exists(_tokenId));
    console.log("An NFT w/ ID %s has been minted to %s", _tokenId, msg.sender);
    return string(
      abi.encodePacked(
          "data:application/json;base64,",
          "ewogICAgIm5hbWUiOiAiTWlkbmlnaHQgSGVybyBIYXQgRmVsbGEiLAogICAgImRlc2NyaXB0aW9uIjogIkFuIE5GVCBmcm9tIHRoZSBoaWdobHkgYWNjbGFpbWVkIE1pZG5pZ2h0IGNvbGxlY3Rpb24iLAogICAgImltYWdlIjogIlBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UiCn0"
      )
    );
  }
}