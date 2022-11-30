# frozen_string_literal: true

# namespace for everthing displayed to user
module Display
  # mixin for messages sent to user
  module Messages
    def self.included(_base)
      include Conversions
    end

    def print_welcome_message
      puts 'Welcome to chess!'
      print_spacer
      puts 'Chess is a two-player turn-based board game. Each turn, a player can move one piece of their color. Each piece has its own move pattern (for example, the King can move 1 square in any direction).'
      print_spacer
      puts "A player wins by putting their oponent's King in check mate. Check mate happens when a King has no available moves."
      print_spacer
      puts "Ready to play? Let's start with names..."
    end

    def print_player_name_prompt(player_number)
      2.times { print_spacer }
      puts "Player #{player_number}, what's your name?"
    end

    def print_player_name_warning
      print_spacer
      puts "\e[31m#ERR:\e[0m Invalid name. Please enter letters and numbers only."
    end

    def print_game_prompt(player)
      print_whose_turn_it_is_anyway(player)
      print_king_in_check_message(player.name) unless player.king.check_positions.length.zero?
      print_available_moves_message(player)
    end

    def print_whose_turn_it_is_anyway(player)
      print_spacer
      puts "#{player.name.upcase}'S TURN (#{player.color} pieces)".bold.underline
    end

    def print_piece_to_move_input
      2.times { print_spacer }
      puts 'What piece do you want to move?'
    end

    def print_invalid_input_warning
      print_spacer
      puts "\e[31m#ERR:\e[0m Invalid input. Please enter a letter a-h, then a number 1-8 (ex: a2)."
    end

    def print_available_moves_message(player)
      print_spacer
      puts 'Here are all of your pieces that currently have valid moves:'
      print_spacer
      player.find_pieces.each do |piece|
        if piece.valid_moves.length.positive?
          print piece.position.sum.even? ? " #{piece.character} ".bg_white : " #{piece.character} ".bg_blue
        end
      end
    end

    def print_no_available_moves_warning
      print_spacer
      puts "\e[31m#ERR:\e[0m This piece has no available moves. Please enter a different piece."
    end

    def print_invalid_piece_warning
      print_spacer
      puts "\e[31m#ERR:\e[0m This is not your piece. You must select a square that has your piece. Please enter a new square."
    end

    def print_piece_destination_input(piece, valid_moves)
      chess_notation_valid_moves = valid_moves.map { |move_array_notation| chess_notation(move_array_notation) }
      print_spacer
      puts "Where do you want to move your #{piece.name} to? Valid moves = #{chess_notation_valid_moves.join(', ')} (marked with \e[31m\u25CF\e[0m above)"
    end

    def print_invalid_destination_warning
      puts "\e[31m#ERR:\e[0m This piece cannot move to the destination you entered. Please enter a new destination."
    end

    def print_king_in_check_message(player_name)
      print_spacer
      puts "\e[31mWARNING:\e[0m #{player_name} your king is in check. Your next move must protect your king!"
    end

    def print_game_winner_message(losing_player, winning_player)
      2.times { print_spacer }
      puts 'GAME OVER!'.green
      print_spacer
      puts "#{losing_player.name} your king is in check mate, you lose. So congrats #{winning_player.name}, you've won! You're so amaaazin!"
    end

    def print_play_again_message
      3.times { print_spacer }
      puts 'Want to play again? Enter Y/N.'
    end

    def print_play_again_warning
      puts "\e[31m#ERR:\e[0m Invalid input. Please enter Y or N."
    end

    def print_loading_board_message
      print_spacer
      puts 'Loading board...'
    end

    def print_spacer
      puts
    end
  end
end
