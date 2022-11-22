# frozen_string_literal: true

# namespace module to better organize the different chess-board pieces
module Pieces
  # the diagonol deviant... the bishop
  class Bishop
    include Pieces::Moves
    attr_reader :name, :color, :position

    def initialize(color, position)
      @name     = 'bishop'
      @color    = color
      @uni      = color == 'white' ? "\u2657" : "\u265D"
      @position = position
    end

    def valid_moves(board)
      valid_diagonol_moves(board, @position, @color)
    end
  end
end
