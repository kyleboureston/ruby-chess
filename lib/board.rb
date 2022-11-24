# frozen_string_literal: true

require_relative 'display/board'

# the one board to rule them all
class Board
  include Display::Board
  attr_reader :data

  def initialize
    @data = generate_board
  end

  def move
    remove(piece, current)
    add(piece, destination)
  end

  def get_king(color)
    @board_arr.select { |piece| piece.name == 'king' && piece.color == color }
  end

  private

  def generate_board(response = [])
    8.times do |index|
      response << case index
                  when 0
                    create_major_row('white', index)
                  when 1
                    create_minor_row('white', index)
                  when 6
                    create_minor_row('black', index)
                  when 7
                    create_major_row('black', index)
                  else
                    create_nil_row
                  end
    end
    response
  end

  def create_minor_row(color, row, response = [])
    8.times { |index| response << Pawn.new(color, [row, index], self) }
    response
  end

  def create_major_row(color, row)
    [
      Rook.new(color, [row, 0], self), Bishop.new(color, [row, 1], self),
      Knight.new(color, [row, 2], self), King.new(color, [row, 3], self),
      Queen.new(color, [row, 4], self), Knight.new(color, [row, 5], self),
      Bishop.new(color, [row, 6], self), Rook.new(color, [row, 7], self)
    ]
  end

  def create_nil_row
    Array.new(8) { nil }
  end

  def remove(piece, current)

  end

  def add(piece, current)

  end
end
