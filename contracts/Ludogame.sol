// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Errors, Events} from "./LudoLibrary.sol";

contract LudoGame {
    struct Player {
        uint position;
        bool hasWon;
    }

    mapping(address => Player) public players;
    address[] public playerList;
    uint public winningPosition = 56;

    function joinGame() public {
        require(players[msg.sender].position == 0, "Already joined");
        players[msg.sender] = Player(0, false);
        playerList.push(msg.sender);
    }

    function rollAndMove() public returns (uint8) {
        if (players[msg.sender].position == 0 && !players[msg.sender].hasWon) {
            revert Errors.NotPlayer();
        }
        if (players[msg.sender].hasWon) {
            revert Errors.GameAlreadyWon();
        }

        uint8 diceRoll = rollDice();
        if (diceRoll < 1 || diceRoll > 6) {
            revert Errors.InvalidDiceRoll();
        }

        emit Events.DiceRolled(msg.sender, diceRoll);

        players[msg.sender].position += diceRoll;

        if (players[msg.sender].position >= winningPosition) {
            players[msg.sender].position = winningPosition;
            players[msg.sender].hasWon = true;
            emit Events.PlayerWon(msg.sender);
        } else {
            emit Events.PlayerMoved(msg.sender, players[msg.sender].position);
        }

        return diceRoll;
    }

    function getPlayerPosition(address player) public view returns (uint) {
        return players[player].position;
    }

    function hasPlayerWon(address player) public view returns (bool) {
        return players[player].hasWon;
    }

    function rollDice() internal view returns (uint8) {
        return uint8((uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % 6) + 1);
    }
}