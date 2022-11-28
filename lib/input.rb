# frozen_string_literal: true

# Central to run the game itself
module Input
  def self.included(_base)
    include Conversions
  end

  private

  def player_name_input
    player_name = gets.chomp
    return player_name if player_name.match(/^[a-z0-9]+$/i)

    print_player_name_warning
    player_name_input
  end

  def player_piece_input(player_piece_positions, board)
    piece_chess_notation = gets.chomp

    # Make sure the player's input was formatted correctly
    valid_input = piece_chess_notation.match(/^[a-h][1-8]$/i)
    print_invalid_input_warning unless valid_input

    # Make sure that the piece selected is the player's piece
    if valid_input
      piece_array_notation = array_notation(piece_chess_notation)
      valid_piece = player_piece_positions.include?(piece_array_notation)
      print_invalid_piece_warning unless valid_piece
    end

    # Make sure that the piece selected has at least 1 move available
    if valid_input && valid_piece
      piece = board.get_piece(piece_array_notation) # This is the Board object
      pieces_valid_moves = piece.valid_moves
      valid_move = pieces_valid_moves.length.positive?
      print_no_available_moves_warning unless valid_move
    end
    # Returns a Piece object
    return piece if valid_input && valid_piece && valid_move

    player_piece_input(player_piece_positions, board)
  end

  def piece_destination_input(valid_moves)
    destination_chess_notation = gets.chomp

    # Make sure the player's input was formatted correctly
    valid_input = destination_chess_notation.match(/^[a-h][1-8]$/i)
    print_invalid_input_warning unless valid_input

    # Make sure the entered destination is valid
    if valid_input
      destination_array_notation = array_notation(destination_chess_notation)
      valid_destination = valid_moves.include?(destination_array_notation)
      print_invalid_destination_warning unless valid_destination
    end

    return destination_array_notation if valid_input && valid_destination

    piece_destination_input(valid_moves)
  end
end
