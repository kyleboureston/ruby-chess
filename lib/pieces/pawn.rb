# frozen_string_literal: true

# the prince of puny and paltry... the pawn
class Pawn < Piece
  attr_reader :name, :character, :passant_vulnerable, :passant_attack_position, :can_upgrade

  def initialize(color, position, board)
    @name                    = 'pawn'
    @character               = color == 'white' ? "\u2659" : "\u265F"
    @passant_vulnerable      = false
    @passant_attack_position = nil
    @can_upgrade             = false
    super(color, position, board)
  end

  def find_valid_moves
    @valid_moves = valid_pawn_moves(@position).reject { |move| @king.puts_king_in_check?(self, move) }
  end

  def update_pawn(position, destination)
    pos_x, = position
    dest_x, dest_y = destination

    @passant_vulnerable = (pos_x - dest_x).abs == 2

    @passant_attack_position = [dest_x + 1, dest_y + 1] if @passant_vulnerable && @color == 'white'
    @passant_attack_position = [dest_x - 1, dest_y - 1] if @passant_vulnerable && @color == 'black'

    @can_upgrade = dest_x == 0 if @color == 'white'
    @can_upgrade = dest_x == 7 if @color == 'black'
  end

  private

  def valid_pawn_moves(position, response = [])
    # PAWN'S ATTACKS
    response << valid_pawn_attacks(position)
    # NORMAL PAWN MOVEMENTS
    response << valid_pawn_normal_moves(position)
    # EN PASSANT ATTACKS
    response << valid_pawn_attacks_en_passant(position)
    # Remove nil from response
    flatten_to_2d(response.compact)
  end

  def valid_pawn_attacks(position, response = [])
    pos_x, pos_y = position
    players_pawn_attacks = @color == 'white' ? PAWN_ATTACKS_WHITE : PAWN_ATTACKS_BLACK
    players_pawn_attacks.each do |move|
      x, y = move
      next_move = [pos_x + x, pos_y + y]
      next if not_valid?(next_move) || blank?(next_move) || contains_friend?(next_move, @color)

      response << next_move
    end
    response.compact
  end

  def valid_pawn_normal_moves(position, response = [])
    pos_x, pos_y = position
    move1 = @color == 'white' ? [pos_x - 1, pos_y] : [pos_x + 1, pos_y]
    move2 = @color == 'white' ? [pos_x - 2, pos_y] : [pos_x + 2, pos_y]

    # pawn can always move forward 1 (assuming no piece in their way)
    response << move1 if valid?(move1) && blank?(move1)
    # black's_starting_row == 1. white's_starting_row == 6
    if (@color == 'black' && pos_x == 1) || (@color == 'white' && pos_x == 6)
      response << move2 if valid?(move2) && blank?(move2)
    end
    response.compact
  end

  def valid_pawn_attacks_en_passant(position, response = [])
    pos_x, pos_y = position
    # can only attack en passant on the col it started on
    return unless pos_y == @starting_col
    # white can only attack black 'en passant' on row 3, and black can only attack white 'en passant' on row 4
    return unless (@color == 'white' && pos_x == 3) || (@color == 'black' && pos_x == 4)

    # get the pieces to the left and the right of the piece
    piece_left = @board.get_piece([pos_x, pos_y - 1])
    piece_right = @board.get_piece([pos_x, pos_y + 1])

    response << check_valid_en_passant_attacks(position, piece_left, -1) unless piece_left.nil?
    response << check_valid_en_passant_attacks(position, piece_right, 1) unless piece_right.nil?
    response.compact
  end

  def check_valid_en_passant_attacks(position, piece_to_attack, y_movement)
    pos_x, pos_y = position
    # only pawns can be attacked en_passant
    return unless piece_to_attack.name == 'pawn'

    # the pawn must have just moved 2 spaces to be vulnerable to en passant

    return unless piece_to_attack.passant_vulnerable

    # [(white moves backwards so -1 / black moves forward so +1)
    @color == 'white' ? [pos_x - 1, pos_y + y_movement] : [pos_x + 1, pos_y + y_movement]
  end
end
