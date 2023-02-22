// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./Base64.sol";

contract Yugasi is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    mapping(uint256 => bool) public activatedSoulBound;

    struct MediaItem {
        string ipfsURL;
        string description;
    }
    mapping(uint256 => MediaItem[]) public mediaItems; 
    
    mapping(uint256 => uint256) public maxMediaItems;
    uint256 public constant DEFAULT_MAX_ITEMS = 5;

    mapping(uint256 => string) public nftImageURIs;
    string nftImageURI = "https://ipfs.io/ipfs/QmaqS9Qq2L4DGeYp2GwELNCVg85v3XGeHj6K6xv9ZVPCFJ";

    constructor() ERC721("Yugasi", "YGS") {
        
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function mintItem(address to, string memory uri) public returns (uint256) {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        
        activatedSoulBound[tokenId] = false;
        maxMediaItems[tokenId] = DEFAULT_MAX_ITEMS;
        
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        return tokenId;
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    // function tokenURI(uint256 tokenId)
    //     public
    //     view
    //     override(ERC721, ERC721URIStorage)
    //     returns (string memory)
    // {
    //     return super.tokenURI(tokenId);
    // }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        string memory stringSoulBound = activatedSoulBound[tokenId] ? "Active" : "Inactive";

        string memory json = Base64.encode(
            abi.encodePacked(
            '{"name": "Yugasi #', Strings.toString(tokenId),
            '", "description": "Immortalize, own, and share your digital legacy.", "image": "',
            nftImageURI,
            '", "attributes": [ { "trait_type": "Media used", "value": ', Strings.toString(mediaItems[tokenId].length),', "max_value":', Strings.toString(maxMediaItems[tokenId]),'}, { "trait_type": "Soulbound", "value": "',
            stringSoulBound,'"} ]}'
            )
        );

        string memory output = string(
            abi.encodePacked("data:application/json;base64,", json)
        );
        
        return output;
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function _activateSoulBound(uint256 tokenId) internal {
        require(msg.sender == ownerOf(tokenId), "You are not the owner of this token");
        activatedSoulBound[tokenId] = true;
    }

    function activateSoulBound(uint256 tokenId) public {
        _activateSoulBound(tokenId);
    }

    function transferFrom(address from, address to, uint256 tokenId) 
        public 
        override(ERC721) 
    {
        if (activatedSoulBound[tokenId]) {
            revert();
        }
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) 
        public 
        override(ERC721) 
    {
        if (activatedSoulBound[tokenId]) {
            revert();
        }
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) 
        public 
        override(ERC721) 
    {
        if (activatedSoulBound[tokenId]) {
            revert();
        }
        super.safeTransferFrom(from, to, tokenId, _data);
    }

    function addMediaItem(uint256 tokenId, string memory ipfsURL, string memory description) public {
        require(msg.sender == ownerOf(tokenId), "You are not the owner of this token");
        require(mediaItems[tokenId].length < maxMediaItems[tokenId], "You have reached the maximum number of media items");
        require(activatedSoulBound[tokenId], "You must activate soul bound before adding media items");
        
        mediaItems[tokenId].push(MediaItem(ipfsURL, description));
    }

    function showMediaItems(uint256 tokenId) public view returns (MediaItem[] memory) {
        return mediaItems[tokenId]; 
    }
}
