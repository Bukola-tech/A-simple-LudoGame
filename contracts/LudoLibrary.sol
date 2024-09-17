// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Errors {
    // Custom error
    error NotPlayer();
    error InvalidDiceRoll();
    error GameAlreadyWon();
    error AlreadyJoined(); 
    
}
library Events {
   
    
    // Events
    event DiceRolled(address indexed player, uint8 result);
    event PlayerMoved(address indexed player, uint position);
    event PlayerWon(address indexed player);
}
