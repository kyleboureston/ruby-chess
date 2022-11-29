# frozen_string_literal: true

# the kismet of kindness... the king
class King < Piece
  attr_reader :name, :character

  def initialize(color, position, board)
    @name = 'king'
    @character = color == 'white' ? "\u2654" : "\u265A"
    super(color, position, board)
  end

  def find_valid_moves
    @valid_moves = valid_king_moves(@position, @color)
  end

  def check?(pos = @position)
    diagonol_check?(pos) || straight_check?(pos) || knight_check?(pos) || pawn_check?(pos) || king_check?(pos)
  end

  def check_mate?(options = 0)
    return unless check?

    # NEED TO CHECK:
    # [1] THE PLACES THE KING CAN MOVE
    # [2] IF ANYONE CAN MOVE IN FRONT OF THE KING
    # [3] IF ANYONE CAN ATTACK THE PIECE ATTACKING THE KING
    valid_king_moves(@position, @color).each do |move|
      x, y = move
      move_option = [@position[0] + x, @position[1] + y]
      options += 1 unless check?(move_option)
    end
    options.zero?
  end

  private

  def valid_king_moves(position, color, response = [])
    KING_MOVES.each { |move| response << check_moves(position, color, move) }
    response.compact
  end

  def diagonol_check?(pos = @position, response = [])
    valid_attackers = ['queen', 'bishop']
    DIAGONOL_MOVES.each { |move| response << check_attack_path(pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def straight_check?(pos = @position, response = [])
    valid_attackers = ['queen', 'rook']
    STRAIGHT_MOVES.each { |move| response << check_attack_path(pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def knight_check?(pos = @position, response = [])
    valid_attackers = ['knight']
    KNIGHT_MOVES.each { |move| response << check_attacks(pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def pawn_check?(pos = @position, response = [])
    valid_attackers = ['pawn']
    players_pawn_attacks = @color == 'white' ? PAWN_ATTACKS_BLACK : PAWN_ATTACKS_WHITE
    players_pawn_attacks.each { |move| response << check_attacks(pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def king_check?(pos = @position, response = [])
    valid_attackers = ['king']
    KING_MOVES.each { |move| response << check_attacks(pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  # All return statements in this method:
  #                          [1] Find the end of the pieces possible movement in the given (x, y) direction
  #                          [2] End the recursion for that path (and return the response)
  #                          [3] Skip adding current new_pos to response
  def check_attack_path(pos, color, move, valid_attackers, response = [])
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return response if not_valid?(new_pos)
    return response if not_blank?(new_pos) && contains_friend?(new_pos, color)

    if not_blank?(new_pos) && contains_foe?(new_pos, color)
      foe = get_foe(new_pos, color)
      return response unless valid_attackers.include?(foe)

      response << new_pos
    end
    check_attack_path(new_pos, color, move, valid_attackers, response)
  end

  def check_attacks(pos, color, move, valid_attackers)
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return if not_valid?(new_pos) || blank?(new_pos)
    return if contains_friend?(new_pos, color)

    foe = get_foe(new_pos, color)
    return unless valid_attackers.include?(foe)

    new_pos
  end
end
