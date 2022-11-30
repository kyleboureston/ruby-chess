# frozen_string_literal: true

# Class for the different players
class Player
  attr_accessor :king
  attr_reader :name, :color

  def initialize(name, color, board)
    @name  = name
    @color = color
    @board = board
    @king  = nil
  end

  def set_king
    @king = @board.get_king(color)
    set_king_on_pieces
  end

  def set_king_on_pieces
    pieces = @board.find_friendly_pieces(@color)
    pieces.each { |piece| piece.add_king(@king) }
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
