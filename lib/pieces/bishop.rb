# frozen_string_literal: true

# the diagonol deviant... the bishop
class Bishop < Piece
  attr_reader :name, :char

  def initialize(color, position, board)
    @name = 'bishop'
    @char = color == 'white' ? "\u2657" : "\u265D"
    super(color, position, board)
  end

  def valid_moves
    valid_diagonol_moves(@position, @color)
  end
end
