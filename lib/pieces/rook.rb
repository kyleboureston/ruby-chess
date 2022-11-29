# frozen_string_literal: true

# the straight shooter... the rook
class Rook < Piece
  attr_reader :name, :character

  def initialize(color, position, board)
    @name = 'rook'
    @character = color == 'white' ? "\u2656" : "\u265C"
    super(color, position, board)
  end

  def find_valid_moves
    @valid_moves = valid_straight_moves(@position, @color)
  end
end
