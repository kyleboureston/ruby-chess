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
    pos_x, pos_y = position

    # 1. PAWN'S ATTACKS
    players_pawn_attacks.each do |move|
      x, y = move
      next_move = [pos_x + x, pos_y + y]
      next if not_valid?(next_move) || blank?(next_move) || contains_friend?(next_move, color)

      response << next_move
    end

    # NORMAL PAWN MOVEMENTS
    move1 = color == 'white' ? [pos_x - 1, pos_y] : [pos_x + 1, pos_y]
    move2 = color == 'white' ? [pos_x - 2, pos_y] : [pos_x + 2, pos_y]
    if [1, 6].include?(pos_x) # [1, 6] are the starting rows
      response << move1 if valid?(move1) && blank?(move1)
      response << move2 if valid?(move2) && blank?(move2)
    else
      response << move1 if valid?(move1) && blank?(move1)
    end
    response.compact
  end
end
