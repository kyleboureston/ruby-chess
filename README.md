# Chess

## Description
Chess is a two-player turn-based board game. Each turn, a player can move one piece of their color. Each piece has its own move pattern (for example, the King can move 1 square in any direction). 

A player wins by putting their opponent's King in check mate. Check mate happens when a King has no available moves.

## Play Here
To play this game:
 1. First click the replit button below
 2. Once on replit.com, click the play button in the center of the screen
 
[![Run on Repl.it](https://repl.it/badge/github/kybow/chess)](https://replit.com/@kybow/chess)

## Technologies used
<p align="left">
<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a>

## Why I created this

This was the final project on The Odin Project's Ruby course. It was nice that I personally love the game of Chess. I always open by attempting Scholar's Mate (don't tell anyone).

## Project Objectives

My two main objectives for this project were:
1. **Full OOP.** I saw OOP and Ruby's power when creating a more complex game like Chess. I created 11 total classes: `Board`, `Player`, `Game`, `Piece`, `Pawn`, `Rook`, `Knight`, `Bishop`, `King`, `Queen`, `ValidMovePlaceholder`.
2. **Superclass.** Believe it or not, this was the first time I used superclasses. They were extremely helpful in organizing my Pieces (Pawn < Piece), and for adding universal functionality to all of my pieces.

## Things I learned / enjoyed

I learned some really great things about Ruby during this project:
* **OOP.** To me, seeing OOP in action was great. I like how clean it makes the code. Things can talk to each other, but everything is safe and organized in its own container.
* **Determining `valid_moves`.** It was easy for the pieces that move a fixed number of spaces (`Pawn`, `Knight`, and `King`). For these, I checked each of their possible moves. Valid moves went to [1] Blank squares, [2] Squares that contained a foe. Invalid moves went to [1] Off-the-board squares, [2] Squares that contained a friend, [3] Moves that put the `King` in check (more on this below). For pieces with a variable number of spaces (`Bishop`, `Rook`, `Queen`) I went through the same process above, but checked their `move_path` recursively.
* **A `valid_move` cannot put `King` in check.** In Chess, a move is invalid if it puts the King in check. To check that a possible move didnt put the `King` into check, I created a `board_clone` (using Marshalling), moved the piece on the `board_clone` and then determined if this move put the `King` in check. If it did, I rejected it as invalid. I did this for each possible move.
* **Determining check.** This was, surprisingly, easy. To determine if the `King` was in check, I reversed the process that I used for determining `valid_moves`. I used the `King` as a starting point, and checked each attack type (ex: `knight_attack`). For example: if 2 squares up and 1 over from my `King` was a `Knight`... well then my `King` was in check.
* **Determining check mate.** This was difficult because there are 3 ways a King can move out of check: [1] Move himself out of check, [2] Another piece attacks the piece attacking him, [3] Another piece moves in front of the king to block him. [1] was easy, but [2] and [3] seemed like big tasks as there were many pieces I had to analyze when checking for them. My breakthrough came when I decided to, at the beginning of each turn, update and store each pieces `valid_moves`. This way, I could easily check if a `King` was in check mate. I pulled all of the `Kings` friendly pieces, and counted the number of `valid_moves` they had. If `valid_moves.length.positive?` then the `King` was not in check_mate.
* **Displaying moveable pieces.** To make things more clear, and add a great visual element to the game, I wanted to show the player all of their pieces with `valid_moves`. I even added the correct color background to the piece (ex: a `Rook` on a white background) to make things more clear. I provide this at the beginning of each turn.
* **Displaying a pieces possible moves.** This was a fun challenge and added another nice visual element to the game. Once the player selected a piece, I wanted to show the player all the possible moves that piece could make. I did this using a little red circle for blank squares and changing under_attack pieces to red.
* **Fun for beginners.** Chess is a game with... a lot of rules. I wanted this to be a fun way for beginners to learn / play. To this end, I did 2 things: [1] The player is only able to select pieces that have `valid_moves`. As a result, beginners won't waste time checking through their pieces to see which they can move. I even displayed the pieces with `valid_moves` at the beginning of their turn. [2] After they select a piece, I showed each square this piece could move to on the board.
