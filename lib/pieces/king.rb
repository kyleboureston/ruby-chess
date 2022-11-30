# frozen_string_literal: true

# the kismet of kindness... the king
class King < Piece
  attr_accessor :check_positions
  attr_reader :name, :character

  def initialize(color, position, board)
    @name = 'king'
    @character = color == 'white' ? "\u2654" : "\u265A"
    @check_positions = nil
    super(color, position, board)
  end

  def find_valid_moves
    @valid_moves = valid_king_moves(@position, @color).reject { |move| puts_king_in_check?(@king, move) }
  end

  # Check whether a move puts the king into check
  def puts_king_in_check?(piece, move)
    x, y = piece.position
    # clone the board
    board_clone = @board.deep_clone
    piece_clone = board_clone.data[x][y]
    # move the piece to the proposed destination
    board_clone.move(piece_clone, move)
    # determine if the move put the king in check (will return nil or an array of positions)
    response = find_check_positions(@position, board_clone)
    # return our response
    !response.nil?
  end

  # Finds what pieces are putting the king in check
  def find_check_positions(pos = @position, board = @board)
    response = []
    response.push(
      diagonol_check(pos, board),
      straight_check(pos, board),
      knight_check(pos, board),
      pawn_check(pos, board),
      king_check(pos, board)
    )
    response = flatten_to_2d(response.compact)
    # [IF] response.length.zero [THEN] this means that for the pos, the king is not in check (so we return nil)
    # [ELSE] we return the response (which is an array of the positions that pieces have the king in check)
    response.length.zero? ? nil : response
  end

  def update_check_positions
    @check_positions = find_check_positions
  end

  def check_mate_positions
    move_options = 0
    # If king isn't currently in check, there's no way he could be in check_mate.
    return nil if @check_positions.nil?

    pieces = @board.find_friendly_pieces(@color)
    pieces.each { |piece| piece.position.length.positive? ? move_options += 1 : move_options }

    move_options.zero?
  end

  private

  def valid_king_moves(position, color, response = [])
    KING_MOVES.each { |move| response << check_moves(position, color, move) }
    response.compact
  end

  # checks if a diagonol attacking piece puts the king in check
  def diagonol_check(pos = @position, board = @board, response = [])
    valid_attackers = ['queen', 'bishop']
    DIAGONOL_MOVES.each { |move| response << check_attack_path(pos, @color, move, valid_attackers, board) }
    flatten_to_2d(response.compact)
  end

  # checks if a straight attacking piece puts the king in check
  def straight_check(pos = @position, board = @board, response = [])
    valid_attackers = ['queen', 'rook']
    STRAIGHT_MOVES.each { |move| response << check_attack_path(pos, @color, move, valid_attackers, board) }
    flatten_to_2d(response.compact)
  end

  # checks if a knight puts the king in check
  def knight_check(pos = @position, board = @board, response = [])
    valid_attackers = ['knight']
    KNIGHT_MOVES.each { |move| response << check_attacks(pos, @color, move, valid_attackers, board) }
    flatten_to_2d(response.compact)
  end

  # checks if a pawn puts the king in check
  def pawn_check(pos = @position, board = @board, response = [])
    valid_attackers = ['pawn']
    players_pawn_attacks = @color == 'white' ? PAWN_ATTACKS_BLACK : PAWN_ATTACKS_WHITE
    players_pawn_attacks.each { |move| response << check_attacks(pos, @color, move, valid_attackers, board) }
    flatten_to_2d(response.compact)
  end

  # checks if another king puts the king in check
  def king_check(pos = @position, board = @board, response = [])
    valid_attackers = ['king']
    KING_MOVES.each { |move| response << check_attacks(pos, @color, move, valid_attackers, board) }
    flatten_to_2d(response.compact)
  end

  # All return statements in this method:
  #                          [1] Find the end of the pieces possible movement in the given (x, y) direction
  #                          [2] End the recursion for that path (and return the response)
  #                          [3] Skip adding current new_pos to response
  def check_attack_path(pos, color, move, valid_attackers, board = @board, response = [])
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return response if not_valid?(new_pos)
    return response if not_blank?(new_pos, board) && contains_friend?(new_pos, color, board)

    if not_blank?(new_pos, board) && contains_foe?(new_pos, color, board)
      foe = get_foe(new_pos, color, board)
      return response unless valid_attackers.include?(foe)

      response << new_pos
    end
    check_attack_path(new_pos, color, move, valid_attackers, board, response)
  end

  def check_attacks(pos, color, move, valid_attackers, board = @board)
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return if not_valid?(new_pos) || blank?(new_pos, board)
    return if contains_friend?(new_pos, color, board)

    foe = get_foe(new_pos, color, board)
    return unless valid_attackers.include?(foe)

    new_pos
  end
end
