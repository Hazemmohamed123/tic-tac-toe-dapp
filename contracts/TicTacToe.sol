// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicTacToe {
    address public player1;
    address public player2;
    address public currentPlayer;

    uint8[9] public board;
    bool public gameActive;
    address public winner;

    modifier onlyPlayers() {
        require(msg.sender == player1 || msg.sender == player2, "Not a player");
        _;
    }

    modifier isTurn() {
        require(msg.sender == currentPlayer, "Not your turn");
        _;
    }

    constructor() {
        player1 = msg.sender;
        gameActive = true;
        currentPlayer = player1;
    }

    function joinGame() public {
        require(player2 == address(0), "Game already full");
        require(msg.sender != player1, "Player1 cannot join again");
        player2 = msg.sender;
    }

    function makeMove(uint8 index) public onlyPlayers isTurn {
        require(gameActive, "Game over");
        require(index >= 0 && index < 9, "Invalid move");
        require(board[index] == 0, "Cell occupied");

        if (msg.sender == player1) {
            board[index] = 1;
            currentPlayer = player2;
        } else {
            board[index] = 2;
            currentPlayer = player1;
        }

        checkWinner();
    }

    function checkWinner() internal {
        uint8[3][8] memory winningCombos = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ];

        for (uint8 i = 0; i < 8; i++) {
            uint8 a = winningCombos[i][0];
            uint8 b = winningCombos[i][1];
            uint8 c = winningCombos[i][2];

            if (
                board[a] != 0 &&
                board[a] == board[b] &&
                board[a] == board[c]
            ) {
                gameActive = false;
                winner = board[a] == 1 ? player1 : player2;
            }
        }
    }

    function resetGame() public onlyPlayers {
        require(!gameActive, "Game still active");

        for (uint8 i = 0; i < 9; i++) {
            board[i] = 0;
        }

        currentPlayer = player1;
        gameActive = true;
        winner = address(0);
    }

    function getBoard() public view returns (uint8[9] memory) {
        return board;
    }
}
