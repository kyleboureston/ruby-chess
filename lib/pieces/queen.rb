# frozen_string_literal: true

# the omnidirectional oligarch... the queen
class Queen < Piece
  attr_reader :name, :color, :position

  def initialize(color, position, board)
    @name = 'queen'
    @uni  = color == 'white' ? "\u2655" : "\u265B"
    super(color, position, board)
  end

  def valid_moves(board)
    valid_omnidirectional_moves(board, @position, @color)
  end
end
