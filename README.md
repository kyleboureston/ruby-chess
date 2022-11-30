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
1. **Full OOP.** I really saw the power of OOP and Ruby when creating a more complex game like Chess. I created 11 total classes: Board, Player, Game, Piece, Pawn, Rook, Knight, Bishop, King, Queen, ValidMovePlaceholder.
2. **Superclass.** Believe it or not, this was the first time I used superclasses. They were extremely helpful in not only organizing my Pieces (Pawn < Piece), but also for adding universal functionality to all of my pieces.

## Things I learned / enjoyed

I learned some really great things about Ruby during this project:
* **OOP.** To me, seeing OOP in action was great. I like the how clean it makes the code. Things can talk to eachother, but everything is safe and organized in it's own container.
* **Displaying Possible Moves.** This was a fun challenge and added another nice visual element to the game. Once the player selected a piece, I wanted to show the player all the possible moves that piece could make. I did this using a little red circle for blank squares and changing under_attack pieces to red.
