# frozen_string_literal: true

# namespace module to better organize the different chess-board pieces
module Pieces
  # the omnidirectional oligarch... the queen
  class Queen
    include Pieces::Moves
    attr_reader :name, :color, :position

    def initialize(color, position)
      @name     = 'queen'
      @color    = color
      @uni      = color == 'white' ? "\u2655" : "\u265B"
      @position = position
    end

    def valid_moves(board)
      valid_omnidirectional_moves(board, @position, @color)
    end
  end
end
