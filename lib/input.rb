# frozen_string_literal: true

# Central to run the game itself
module Input
  def self.included(_base)
    include Display::Messages
  end

  private

  def player_name_input
    player_name = gets.chomp
    return player_name if player_name.match(/^[a-z0-9]+$/i)

    print_player_name_warning
    player_name_input
  end

  def player_piece_input(player_piece_positions, board)
    piece_position = gets.chomp

    # Make sure the player's input was formatted correctly
    valid_input = piece_position.match(/^[a-h][1-8]$/i)
    unless valid_input
      print_invalid_input_warning
      player_piece_input(player_piece_positions, board)
    end

    # Make sure that the piece selected is the player's piece
    col, row = piece_position.split('') # Col, row (not row, col) as chess notation starts with col, then row (ex: A1)
    numeric_piece_position = [row.to_i - 1, 'ABCDEFGH'.index(col.upcase)] # Board uses zero-based indexing
    valid_piece = player_piece_positions.include?(numeric_piece_position)
    unless valid_piece
      print_invalid_piece_warning
      player_piece_input(player_piece_positions, board)
    end

    # Make sure that the piece selected has at least 1 move available
    piece = board.get_piece(numeric_piece_position) # This is the Board object
    valid_moves = piece.valid_moves
    unless valid_moves.length.positive?
      print_no_available_moves_warning
      player_piece_input(player_piece_positions, board)
    end

    piece # Returns a Piece object
  end

  def piece_destination_input(valid_moves)
    destination = gets.chomp
    valid_input = destination.match(/^[a-h][1-8]$/i)
    unless valid_input
      print_invalid_input_warning
      piece_destination_input(valid_moves)
    end

    col, row = destination.split('') # Col, row (not row, col) as chess notation starts with col, then row (ex: A1)
    numeric_desination_position = [row.to_i - 1, 'ABCDEFGH'.index(col.upcase)] # Board uses zero-based indexing
    valid_destination = valid_moves.include?(numeric_desination_position)
    unless valid_destination
      print_invalid_destination_warning
      piece_destination_input(valid_moves)
    end

    numeric_desination_position
  end
end
