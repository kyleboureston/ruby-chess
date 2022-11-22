# frozen_string_literal: true

# the straight shooter... the rook
class Rook < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'rook'
    @uni  = color == 'white' ? "\u2656" : "\u265C"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_straight_moves(board, @position, @color)
  end
end
