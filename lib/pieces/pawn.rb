# frozen_string_literal: true

# the prince of puny and paltry... the pawn
class Pawn < Piece
  attr_reader :name, :char

  def initialize(color, position, board)
    @name = 'pawn'
    @char = color == 'white' ? "\u2659" : "\u265F"
    super(color, position, board)
  end

  def valid_moves
    valid_pawn_moves(@position, @color)
  end

  private

  def valid_pawn_moves(position, color, response = [])
    position_x, position_y = position

    # FIRST TAKE CARE OF THE PAWN'S ATTACKS
    PAWN_ATTACK_MOVES.each do |move|
      x, y = move
      next_move = [position_x + x, position_y + y]
      next if not_valid?(next_move) || blank?(next_move) || contains_friend?(next_move, color)

      response << next_move
    end

    # THEN THE NORMAL PAWN MOVEMENTS
    move1 = [position_x + 1, position_y]
    move2 = [position_x + 2, position_y]
    if position_x == 1 # This is the starting row
      response << move1 if valid?(move1) && blank?(move1)
      response << move2 if valid?(move2) && blank?(move2)
    else
      response << move1 if valid?(move1) && blank?(move1)
    end
    response.compact
  end
end
