# frozen_string_literal: true

# Central to run the game itself
module Input
  def self.included(_base)
    include Display::Messages
  end

  private

  # Chess notation (A1) does not come in the same as array notation ([0, 0]). There are 2 changes:
  #   [1] In arrays, row comes first. In chess, row comes second.
  #       TO FIX: I swap the two.
  #   [2] Chess notation uses a letter for the column. Arrays do not
  #   [3] Arrays use 0-based indexing. Chess does not.
  #       TO FIX: subtract 1 from the chess notation
  #   [4] In arrays print in order. So [0, 0] will print first. In chess, a8 prints first.
  #       TO FIX: convert this
  def convert_array_position(chess_position)
    # [1] Swap col and row
    col, row = chess_position.split('')
    # [2] Convert col to number (already zero-base indexed)
    col = 'ABCDEFGH'.index(col.upcase)
    # [3] Convert row to zero-based indexing
    row = row.to_i - 1
    # [4] Convert the row to print in array notation order
    row -= 7
    row = row.abs
    # Return the chess position converted to the corresponding array position
    [row, col]
  end

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
    unless valid_input
      print_invalid_input_warning
      player_piece_input(player_piece_positions, board)
    end

    # Make sure that the piece selected is the player's piece
    piece_array_notation = convert_array_position(piece_chess_notation)
    valid_piece = player_piece_positions.include?(piece_array_notation)
    unless valid_piece
      print_invalid_piece_warning
      player_piece_input(player_piece_positions, board)
    end

    # Make sure that the piece selected has at least 1 move available
    piece = board.get_piece(piece_array_notation) # This is the Board object
    p piece.position
    p piece.name
    valid_moves = piece.valid_moves
    unless valid_moves.length.positive?
      print_no_available_moves_warning
      player_piece_input(player_piece_positions, board)
    end

    piece # Returns a Piece object
  end

  def piece_destination_input(valid_moves)
    destination_chess_notation = gets.chomp
    valid_input = destination_chess_notation.match(/^[a-h][1-8]$/i)
    unless valid_input
      print_invalid_input_warning
      piece_destination_input(valid_moves)
    end

    destination_array_notation = convert_array_position(destination_chess_notation)
    valid_destination = valid_moves.include?(destination_array_notation)
    unless valid_destination
      print_invalid_destination_warning
      piece_destination_input(valid_moves)
    end

    destination_array_notation
  end
end
