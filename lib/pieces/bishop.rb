# frozen_string_literal: true

# the diagonol deviant... the bishop
class Bishop < Piece
  attr_reader :name, :character

  def initialize(color, position, board)
    @name = 'bishop'
    @character = color == 'white' ? "\u2657" : "\u265D"
    super(color, position, board)
  end

  def find_valid_moves
    @valid_moves = valid_diagonol_moves(@position, @color).reject { |move| @king.puts_king_in_check?(self, move) }
  end
end
