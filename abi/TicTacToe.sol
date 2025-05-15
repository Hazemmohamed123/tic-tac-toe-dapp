// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicTacToe {
    enum Player { None, X, O }
    Player[9] public board;
    address public playerX;
    address public playerO;
    Player public currentPlayer;
    bool public gameActive;

    constructor() {
        gameActive = true;
        currentPlayer = Player.X;
    }

    function joinGame() public {
        require(playerX == address(0) || playerO == address(0), "Game is full");
        if (playerX == address(0)) {
            playerX = msg.sender;
        } else if (playerO == address(0)) {
            playerO = msg.sender;
        }
    }

    function makeMove(uint8 index) public {
        require(gameActive, "Game is not active");
        require(index >= 0 && index < 9, "Invalid index");
        require(board[index] == Player.None, "Cell already occupied");
        require(
            (currentPlayer == Player.X && msg.sender == playerX) ||
            (currentPlayer == Player.O && msg.sender == playerO),
            "Not your turn"
        );

        board[index] = currentPlayer;
        if (checkWin()) {
            gameActive = false;
        } else {
            currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
        }
    }

    function checkWin() internal view returns (bool) {
        uint8[3][8] memory winningCombinations = [
            [0,1,2],[3,4,5],[6,7,8],
            [0,3,6],[1,4,7],[2,5,8],
            [0,4,8],[2,4,6]
        ];

        for (uint8 i = 0; i < winningCombinations.length; i++) {
            uint8[3] memory combo = winningCombinations[i];
            if (
                board[combo[0]] != Player.None &&
                board[combo[0]] == board[combo[1]] &&
                board[combo[1]] == board[combo[2]]
            ) {
                return true;
            }
        }
        return false;
    }
}