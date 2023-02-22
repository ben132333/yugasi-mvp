# Yugasi 

## Introduction

This is a proof of concept of a project called yugasi: https://yugasi.com/

The idea is to immportalise, own, and share your persnal legacy on-chain. 

POC features:
- ERC721 contract: any user can mint a Yugasi NFT
- The owner of an NFT has the ability to make any token soulbound
- Adter the user activates "SoulBound," they can add N items to their Yugasi. This is similar to customising an ENS domain (see the "TextResolver" contract in ENS). 
- Experimental front-end to interact with the smart contract. 

Status: 
- the code is functional but still sloppy
- test needs to be written
- security needs to be considered
- gas optimisation needs to be considered

## POC Live

Here is a React app to mint a Yugasi NFT on Goerli and interact with the smart contract:  
https://choupape-check-mvp.surge.sh/debugcontracts

Here is the deployed and verified smart contract on Goerli:   
https://goerli.etherscan.io/address/0x7ab7507904d28de85a1a4b0f02c96d9af1c416d0#code

# Setup 

Clone this repo: 

This dapp is built with scaffold-eth as development environment. Check the prerequisite installations and how to run this repo in localhost. 

