# frozen_string_literal: true

# Class for the different players
class Player
  attr_reader :name, :color

  def initialize(name, color, board)
    @name  = name
    @color = color
    @board = board
  end

  def find_pieces
    response = []
    @board.data.flatten.each do |piece|
      next if piece.nil?

      response << piece if piece.color == @color
    end
    response
  end

  def piece_positions
    pieces = find_pieces
    pieces.map(&:position)
  end
end
