# Chess

## Description
Chess is a two-player turn-based board game. Each turn, a player can move one piece of their color. Each piece has its own move pattern (for example, the King can move 1 square in any direction). 

A player wins by putting their oponent's King in check mate. Check mate happens when a King has no available moves.

## Play Here
To play this game:
 1. First click the replit button below
 2. Once on replit.com, click the play button in the center of the screen
 
[![Run on Repl.it](https://repl.it/badge/github/kybow/chess)](https://replit.com/@kybow/chess)

## Technologies used
<p align="left">
<a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a>

## Why I created this

This was the final project on The Odin Project's Ruby course. It was nice that on a personal level, I love the game of chess. I always open attempting Scholar's Mate (don't tell anyone).

## Project Objectives

My two main objectives for this project were:
1. **Full OOP.** I really saw the power of OOP and Ruby when creating a more complex game like Chess. I created 11 total classes: `Board`, `Player`, `Game`, `Piece`, `Pawn`, `Rook`, `Knight`, `Bishop`, `King`, `Queen`, `ValidMovePlaceholder`.
2. **Superclass.** Believe it or not, this was the first time I used superclasses. They were extremely helpful in not only organizing my Pieces (Pawn < Piece), but also for adding universal functionality to all of my pieces.

## Things I learned / enjoyed

I learned some really great things about Ruby during this project:
* **OOP.** To me, seeing OOP in action was great. I like the how clean it makes the code. Things can talk to eachother, but everything is safe and organized in its own container.
 
* **Displaying Possible Moves.** This was a fun challenge and added another nice visual element to the game. Once the player selected a piece, I wanted to show the player all the possible moves that piece could make. I did this using a little red circle for blank squares and changing under_attack pieces to red.
 * **Determining valid_moves.** This was fun. It was easy to determine if a piece could move with no pieces in front of them.  The difficulty came when determining how far the piece, like a Bishop, could move. To solve this issue, I used recursion to check a piece's move_path. Starting with a square the piece could move to, I checked if it was a square on the board. If it wasn\'t . If it was, I then checked if it was blank. If it was, it was a valid_move. If it wasn't, I checked 
 * **Valid_moves cannot put King in check.** In chess, a move is invalid if it puts the King in check. 
 * **Determining Check.** 
 * **Determining Check Mate.** This was difficult because there are 3 ways a King can move out of check: [1] Move himself out of check, [2] Another piece attacks the piece attacking him, [3] Another piece moves in front of the king to block him. [1] was easy, but [2] and [3] seemed like big tasks as there were many pieces I had to analyze when checking for them. My breakthrough came when I decided to, at the beginning of each turn, update and store each piece's valid_moves. This way, I could easily check if
