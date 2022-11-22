# frozen_string_literal: true

# the prince of puny and paltry... the pawn
class Pawn < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'pawn'
    @uni  = color == 'white' ? "\u2659" : "\u265F"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_pawn_moves(board, @position, @color)
  end

  private

  def valid_pawn_moves(board, position, color, response = [])
    position_x, position_y = position

    # FIRST TAKE CARE OF THE PAWN'S ATTACKS
    PAWN_ATTACK_MOVES.each do |move|
      x, y = move
      next_move = [position_x + x, position_y + y]
      next if not_valid?(next_move) || (not_blank?(board, next_move) && !contains_foe?(board, next_move, color))

      response << next_move
    end

    # THEN THE NORMAL PAWN MOVEMENTS
    if position_x == 1 # This is the starting row
      next_move = [position_x + 2, position_y]
      response << next_move if valid?(next_move) && blank?(board, next_move)
    else
      next_move = [position_x + 1, position_y]
      response << next_move if valid?(next_move) && blank?(board, next_move)
    end

    response.compact
  end
end
