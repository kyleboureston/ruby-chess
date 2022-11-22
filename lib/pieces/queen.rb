# frozen_string_literal: true

# the omnidirectional oligarch... the queen
class Queen < Piece
  attr_reader :name, :uni

  def initialize(color, position, board)
    @name = 'queen'
    @uni  = color == 'white' ? "\u2655" : "\u265B"
    super(color, position, board)
  end

  def valid_moves
    valid_omnidirectional_moves(@position, @color)
  end
end
