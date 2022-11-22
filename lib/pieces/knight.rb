# frozen_string_literal: true

# the L of lawlessness... the knight
class Knight < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'knight'
    @uni  = color == 'white' ? "\u2658" : "\u265E"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_knight_moves(board, @position, @color)
  end

  private

  def valid_knight_moves(board, position, color, response = [])
    KNIGHT_MOVES.each do |move|
      x, y = move
      response << check_moves(board, position, color, x, y)
    end
    response.compact
  end
end
