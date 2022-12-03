# frozen_string_literal: true

# Central to run the game itself
class Game
  include Input
  include Display::Messages

  def initialize
    @board               = nil
    @player1             = nil
    @player2             = nil
    @current_player      = nil
    @next_player         = nil
  end

  def play
    clear_screen
    print_welcome_message
    # sleep(2)
    setup_board
    setup_players
    @board.update_valid_moves
    print_loading_board_message
    # sleep(2)
    play_turn until @current_player.king.check_mate?
    conclusion(@current_player, @next_player) # losing_player, winning_player
  end

  def setup_players
    @player1 = create_player(1, 'black')
    @player2 = create_player(2, 'white')
    set_player_order
    set_players_kings
  end

  def create_player(player_number, player_color)
    print_player_name_prompt(player_number)
    player_name = player_name_input

    Player.new(player_name, player_color, @board)
  end

  def setup_board
    # create a blank board
    @board = Board.new
    # add the pieces to the board
    @board.setup
  end

  def play_turn
    @board.display
    print_game_prompt(@current_player)
    # Get the piece the player wants to move
    piece = player_piece_input(@current_player.piece_positions, @board) # returns a piece object
    valid_moves = piece.valid_moves
    # Mark this piece as selected and show the valid moves for the piece
    update_board_with_selected(piece, valid_moves)
    # Get the destination that the player wants to move the selected piece
    print_piece_destination_input(piece, valid_moves)
    position = piece.position
    destination = piece_destination_input(valid_moves)
    # Unselect the piece, remove the valid moves from board, and move the piece
    move_piece(piece, position, destination)
    upgrade_piece(piece) if piece.name == 'pawn' && piece.can_upgrade
    # switch to the next player
    switch_players
  end

  private

  def clear_screen
    system 'clear'
  end

  def set_player_order
    @current_player = @player1
    @next_player = @player2
  end

  def set_players_kings
    @player1.set_king
    @player2.set_king
  end

  def update_board_with_selected(piece, valid_moves)
    piece.mark_selected
    @board.add_valid_moves(valid_moves)
    @board.display
  end

  def move_piece(piece, position, destination)
    # update the piece's data
    piece.update(position, destination)
    # remove the ValidMovePlaceholders and remove color off of 'under_attack' players
    @board.remove_valid_moves
    # move the player on the board itself to the destination
    @board.move(piece, destination)
    # update the valid_moves of all the pieces
    @board.update_valid_moves
  end

  def upgrade_piece(piece)
    position = piece.position
    valid_upgrades = find_valid_upgrade_pieces(piece, position)
    valid_upgrade_names = valid_upgrades.map(&:name).uniq

    print_upgrade_message(@current_player.name, piece, valid_upgrade_names)
    upgrade_piece_name = upgrade_input(piece, valid_upgrade_names)

    upgrade_piece = valid_upgrades.find { |valid_upgrade| valid_upgrade.name == upgrade_piece_name }
    @board.add(upgrade_piece, position)
    upgrade_piece.update_position(position)
    upgrade_piece.add_king(piece.king)
  end

  def find_valid_upgrade_pieces(piece, position)
    players_major_pieces = @board.find_friendly_pieces(piece.color)
    players_major_pieces_names = players_major_pieces.map(&:name).uniq

    @board
      .create_major_row(piece.color, position[0])
      .reject { |major_piece| players_major_pieces_names.include?(major_piece) }
  end

  def switch_players
    next_player = @current_player == @player1 ? @player2 : @player1
    @next_player = @current_player
    @current_player = next_player
  end

  def conclusion(losing_player, winning_player)
    @board.display
    print_game_winner_message(losing_player, winning_player)
    print_play_again_message
    play_again = play_again_input
    if play_again == 'Y'
      Game.new.play
    else
      5.times { print_spacer }
    end
  end
end
