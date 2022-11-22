# frozen_string_literal: true

# the diagonol deviant... the bishop
class Bishop < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'bishop'
    @uni  = color == 'white' ? "\u2657" : "\u265D"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_diagonol_moves(board, @position, @color)
  end
end
