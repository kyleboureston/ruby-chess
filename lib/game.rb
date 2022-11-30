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
  end

  def play
    clear_screen
    print_welcome_message
    sleep(2)
    setup_board
    setup_players
    update_pieces_valid_moves
    print_loading_board_message
    sleep(2)
    play_turn until @current_player.king.check_mate?
    conclusion(@current_player, next_player)
  end

  def setup_players
    @player1 = create_player(1, 'black')
    @player2 = create_player(2, 'white')
    set_current_player
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
    # Display the board and initial message to user
    @board.display
    print_game_prompt(@current_player)
    # Get the piece the player wants to move
    print_piece_to_move_input(@current_player)
    piece = player_piece_input(@current_player.piece_positions, @board) # returns a piece object
    valid_moves = piece.valid_moves
    # Mark this piece as selected and show the valid moves for the piece
    update_board_with_selected(piece, valid_moves)
    # Get the destination that the player wants to move the selected piece
    print_piece_destination_input(piece, valid_moves)
    destination = piece_destination_input(valid_moves)
    # Unselect the piece, remove the valid moves from board, and move the piece
    move_piece(piece, destination)
    # Switch to the next player and determine if that player's king is in check
    next_player
    check_on_king
  end

  private

  def clear_screen
    system 'clear'
  end

  def set_players_kings
    @player1.set_king
    @player2.set_king
  end

  def set_current_player
    @current_player = @player1
  end

  def next_player
    next_player = @current_player == @player1 ? @player2 : @player1
    @current_player = next_player
  end

  def update_board_with_selected(piece, valid_moves)
    piece.mark_selected
    @board.add_valid_moves(valid_moves)
    @board.display
  end

  def move_piece(piece, destination)
    # remove the ValidMovePlaceholders and remove color off of 'under_attack' players
    @board.remove_valid_moves
    # move the player on the board itself to the destination
    @board.move(piece, destination)
    # update the piece's data
    piece.update(destination)
    # update the valid_moves of all the pieces
    update_pieces_valid_moves
  end

  def update_pieces_valid_moves
    @board.update_valid_moves
  end

  def check_on_king
    @current_player.king.update_check_positions
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
