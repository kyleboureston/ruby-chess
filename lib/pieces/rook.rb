# frozen_string_literal: true

# namespace module to better organize the different chess-board pieces
module Pieces
  # the straight shooter... the rook
  class Rook
    include Pieces::Moves
    attr_reader :name, :color, :position

    def initialize(color, position)
      @name     = 'rook'
      @color    = color
      @uni      = color == 'white' ? "\u2656" : "\u265C"
      @position = position
    end

    def valid_moves(board)
      valid_straight_moves(board, @position, @color)
    end
  end
end
