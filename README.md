# Yugasi 

## Introduction

This is a proof of concept for a project called Yugasi: https://yugasi.com/

The idea is to immortalize, own, and share your personal legacy on-chain. 

POC features:
- ERC721 contract: any user can mint a Yugasi NFT
- The owner of an NFT has the ability to make any token soulbound
- After the user activates "SoulBound," they can add N items to their Yugasi. This is like customizing an ENS domain (see the "TextResolver" contract in ENS). 
- Experimental front-end to interact with the smart contract. 

Status: 
- Functional POC ready
- TODO: code cleanup
- TODO: write tests
- TODO: consider security threats of smart contracts
- TODO: consider gas optimization

## POC Live

Here is a React app to mint a Yugasi NFT on Goerli and interact with the smart contract:  
https://choupape-check-mvp.surge.sh/debugcontracts

Here is the deployed and verified smart contract on Goerli:   
https://goerli.etherscan.io/address/0x7ab7507904d28de85a1a4b0f02c96d9af1c416d0#code

# Setup 

Clone this repo: 
```bash
git clone https://github.com/ben132333/yugasi-mvp.git
```

This dapp is built with scaffold-eth as the development environment. Check the prerequisite installations and how to run this repo in localhost:  
https://github.com/scaffold-eth/scaffold-eth/blob/master/README.md
