# frozen_string_literal: true

# the one board to rule them all
class Board
  include Display::Board
  attr_reader :data

  def initialize
    @data = nil
  end

  def setup
    @data = generate_board
  end

  def update_valid_moves
    @data.each do |row|
      row.each do |square|
        next if square.nil?

        square.find_valid_moves
      end
    end
  end

  def get_piece(piece_position)
    row, col = piece_position
    @data[row][col]
  end

  def get_king(color)
    @data.flatten.select do |piece|
      next if piece.nil?

      piece.name == 'king' && piece.color == color
    end.first
  end

  def find_friendly_pieces(color)
    response = []
    @data.flatten.each do |piece|
      next if piece.nil?

      response << piece if piece.color == color
    end
    response
  end

  # valid_moves is an array of valid-move arrays (ex: [[0, 0], [2, 4], [1, 3]])
  def add_valid_moves(valid_moves)
    valid_moves.each do |valid_move|
      row, col = valid_move
      # If square is blank, add your valid move placeholder
      if @data[row][col].nil?
        @data[row][col] = ValidMovePlaceholder.new('red', valid_move, self)
      # If square contains a foe, set the foe under attack
      else
        piece = @data[row][col]
        piece.set_under_attack
      end
    end
  end

  def remove_valid_moves
    @data.map! do |row|
      row.map! do |piece|
        next if piece.nil?

        piece.set_safe
        piece.name == 'valid_move' ? nil : piece
      end
    end
  end

  # Used Marshal.load as game is all loaded within memory
  def deep_clone
    serialized = Marshal.dump(self)
    Marshal.load(serialized)
  end

  def move(piece, destination)
    remove(piece)
    add(piece, destination)
  end

  private

  def generate_board(response = [])
    8.times do |index|
      response << case index
                  when 0
                    create_major_row('black', index)
                  when 1
                    create_minor_row('black', index)
                  when 6
                    create_minor_row('white', index)
                  when 7
                    create_major_row('white', index)
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
      Rook.new(color, [row, 0], self), Knight.new(color, [row, 1], self),
      Bishop.new(color, [row, 2], self), Queen.new(color, [row, 3], self),
      King.new(color, [row, 4], self), Bishop.new(color, [row, 5], self),
      Knight.new(color, [row, 6], self), Rook.new(color, [row, 7], self)
    ]
  end

  def create_nil_row
    Array.new(8) { nil }
  end

  def remove(piece_to_remove)
    @data.map! do |row|
      row.map! do |piece|
        next if piece.nil?

        piece.position == piece_to_remove.position ? nil : piece
      end
    end
  end

  # For reference, this can handle BOTH when a piece is added (moved) to [1] a blank square AND [2] a square with a foe
  def add(piece, destination)
    row, col = destination
    @data[row][col] = piece
  end
end
