# frozen_string_literal: true

# namespace module to better organize the different chess-board pieces
module Pieces
  # mixin to give all the pieces their actual movements.
  module Moves
    DIAGONOL_MOVES = [[1, 1], [1, -1], [-1, 1], [-1, -1]].freeze
    STRAIGHT_MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
    KNIGHT_MOVES = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2]].freeze
    PAWN_MOVES = [[1, 0], [2, 0]].freeze
    PAWN_ATTACK_MOVES = [[1, 1], [1, -1]].freeze
    KING_MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]].freeze

    private

    def valid_diagonol_moves(board, position, color, response = [])
      DIAGONOL_MOVES.each { |move| response << check_move_path(board, position, color, move) }
      flatten_to_2d(response.compact)
    end

    def valid_straight_moves(board, position, color, response = [])
      STRAIGHT_MOVES.each { |move| response << check_move_path(board, position, color, move) }
      flatten_to_2d(response.compact)
    end

    def valid_omnidirectional_moves(board, position, color, response = [])
      response << valid_diagonol_moves(board, position, color)
      response << valid_straight_moves(board, position, color)
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
    def check_move_path(board, pos, color, move, response = [])
      x, y = move
      new_pos = [pos[0] + x, pos[1] + y]

      return response if not_valid?(new_pos)
      return response if not_blank?(board, new_pos) && contains_friend?(board, new_pos, color)

      response << new_pos
      return response if not_blank?(board, new_pos) && contains_foe?(board, new_pos, color)

      check_move_path(board, new_pos, color, move, response)
    end

    def check_moves(board, pos, color, move)
      x, y = move
      new_pos = [pos[0] + x, pos[1] + y]

      return if not_valid?(new_pos)
      return if not_blank?(board, new_pos) && contains_friend?(board, new_pos, color)

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

    def blank?(board, pos, x = pos[0], y = pos[1])
      board[x].nil? || board[x][y].nil?
    end

    def not_blank?(board, pos, x = pos[0], y = pos[1])
      !board[x].nil? && !board[x][y].nil?
    end

    def get_foe(board, pos, color, x = pos[0], y = pos[1])
      piece = board[x][y]
      piece.name if piece.color != color
    end

    def contains_foe?(board, pos, color, x = pos[0], y = pos[1])
      piece = board[x][y]
      piece.color != color
    end

    def contains_friend?(board, pos, color, x = pos[0], y = pos[1])
      piece = board[x][y]
      piece.color == color
    end
  end
end
