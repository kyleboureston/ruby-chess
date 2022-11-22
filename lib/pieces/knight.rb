# frozen_string_literal: true

# namespace module to better organize the different chess-board pieces
module Pieces
  # the L of lawlessness... the knight
  class Knight
    include Pieces::Moves
    attr_reader :name, :color, :position

    def initialize(color, position)
      @name     = 'knight'
      @color    = color
      @uni      = color == 'white' ? "\u2658" : "\u265E	"
      @position = position
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
end
