# frozen_string_literal: true

# the kismet of kindness... the king
class King < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'king'
    @uni  = color == 'white' ? "\u2654" : "\u265A"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_king_moves(board, @position, @color)
  end

  def check?(board, position = @position)
    diagonol_check?(board, position) || straight_check?(board, position) || knight_check?(board, position) || pawn_check?(board, position) || king_check?(board, position)
  end

  def check_mate?(board, options = 0)
    valid_king_moves(board, @position, @color).each do |move|
      x, y = move
      move_option = [@position[0] + x, @position[1] + y]
      options += 1 unless check?(board, move_option)
    end
    options.zero?
  end

  private

  def valid_king_moves(board, position, color, response = [])
    KING_MOVES.each { |move| response << check_moves(board, position, color, move) }
    response.compact
  end

  def diagonol_check?(board, pos = @position, response = [])
    valid_attackers = ['queen', 'bishop']
    DIAGONOL_MOVES.each { |move| response << check_attack_path(board, pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def straight_check?(board, pos = @position, response = [])
    valid_attackers = ['queen', 'rook']
    STRAIGHT_MOVES.each { |move| response << check_attack_path(board, pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def knight_check?(board, pos = @position, response = [])
    valid_attackers = ['knight']
    KNIGHT_MOVES.each { |move| response << check_attacks(board, pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def pawn_check?(board, pos = @position, response = [])
    valid_attackers = ['pawn']
    PAWN_ATTACK_MOVES.each { |move| response << check_attacks(board, pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  def king_check?(board, pos = @position, response = [])
    valid_attackers = ['king']
    KING_MOVES.each { |move| response << check_attacks(board, pos, @color, move, valid_attackers) }
    flatten_to_2d(response.compact).length.positive?
  end

  # All return statements in this method:
  #                          [1] Find the end of the pieces possible movement in the given (x, y) direction
  #                          [2] End the recursion for that path (and return the response)
  #                          [3] Skip adding current new_pos to response
  def check_attack_path(board, pos, color, move, valid_attackers, response = [])
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return response if not_valid?(new_pos)
    return response if not_blank?(board, new_pos) && contains_friend?(board, new_pos, color)

    if not_blank?(board, new_pos) && contains_foe?(board, new_pos, color)
      foe = get_foe(board, new_pos, color)
      return response unless valid_attackers.include?(foe)

      response << new_pos
    end
    check_attack_path(board, new_pos, color, move, valid_attackers, response)
  end

  def check_attacks(board, pos, color, move, valid_attackers)
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return if not_valid?(new_pos) || blank?(board, new_pos)
    return if contains_friend?(board, new_pos, color)

    foe = get_foe(board, new_pos, color)
    return unless valid_attackers.include?(foe)

    new_pos
  end
end
