# frozen_string_literal: true

# mixin to give all the pieces their actual movements.
class Piece
  attr_accessor :position, :selected, :under_attack, :valid_moves
  attr_reader :board, :color

  DIAGONOL_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
  STRAIGHT_MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
  KNIGHT_MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze
  PAWN_ATTACKS_WHITE = [[-1, -1], [-1, 1]].freeze
  PAWN_ATTACKS_BLACK = [[1, 1], [1, -1]].freeze
  KING_MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze

  def initialize(color, position, board)
    @selected     = false
    @under_attack = false
    @valid_moves  = nil
    @color        = color
    @position     = position
    @board        = board
  end

  def update(destination)
    mark_unselected
    update_position(destination)
    find_valid_moves
  end

  def mark_selected
    self.selected = true
  end

  def mark_unselected
    self.selected = false
  end

  def set_under_attack
    self.under_attack = true
  end

  def set_safe
    self.under_attack = false
  end

  private

  def valid_diagonol_moves(position, color, response = [])
    DIAGONOL_MOVES.each { |move| response << check_move_path(position, color, move) }
    flatten_to_2d(response.compact)
  end

  def valid_straight_moves(position, color, response = [])
    STRAIGHT_MOVES.each { |move| response << check_move_path(position, color, move) }
    flatten_to_2d(response.compact)
  end

  def valid_omnidirectional_moves(position, color, response = [])
    response << valid_diagonol_moves(position, color)
    response << valid_straight_moves(position, color)
    flatten_to_2d(response.compact)
  end

  # The first 2 return statements:
  #                          [1] Find the end of the pieces possible movement in the given (x, y) direction
  #                          [2] End the recursion, for that path  (and return the response)
  #                          [3] Skip adding current new_pos to response
  # The final return statement:
  #                          [1] Find the end of the pieces possible movement in the given (x, y) direction
  #                          [2] End the recursion,
  #                          [3] Do allow the new_pos to be added to the response
  #                             (as a square that contains a foe is a valid move)
  def check_move_path(pos, color, move, response = [])
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return response if not_valid?(new_pos)
    return response if not_blank?(new_pos) && contains_friend?(new_pos, color)

    response << new_pos
    return response if not_blank?(new_pos) && contains_foe?(new_pos, color)

    check_move_path(new_pos, color, move, response)
  end

  def check_moves(pos, color, move)
    x, y = move
    new_pos = [pos[0] + x, pos[1] + y]

    return if not_valid?(new_pos)
    return if not_blank?(new_pos) && contains_friend?(new_pos, color)

    new_pos
  end

  def flatten_to_2d(arr, response = [])
    arr.each { |first| first.each { |second| response << second } }
    response
  end

  def valid?(pos, x = pos[0], y = pos[1])
    x.between?(0, 7) && y.between?(0, 7)
  end

  def not_valid?(pos, x = pos[0], y = pos[1])
    !x.between?(0, 7) || !y.between?(0, 7)
  end

  def blank?(pos, x = pos[0], y = pos[1])
    @board.data[x].nil? || @board.data[x][y].nil?
  end

  def not_blank?(pos, x = pos[0], y = pos[1])
    !@board.data[x].nil? && !@board.data[x][y].nil?
  end

  def get_foe(pos, color, x = pos[0], y = pos[1])
    piece = @board.data[x][y]
    piece.name if piece.color != color
  end

  def contains_foe?(pos, color, x = pos[0], y = pos[1])
    piece = @board.data[x][y]
    piece.color != color
  end

  def contains_friend?(pos, color, x = pos[0], y = pos[1])
    piece = @board.data[x][y]
    piece.color == color
  end

  def update_position(destination)
    self.position = destination
  end
end
