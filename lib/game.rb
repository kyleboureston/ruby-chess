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
    @current_player_king = nil
  end

  def play
    clear_screen
    print_welcome_message
    # sleep(2)
    create_board
    create_players
    set_current_player
    play_turn until @current_player_king.check_mate?
    conclusion
  end

  def create_players
    @player1 = create_player(1, 'black')
    @player2 = create_player(2, 'white')
  end

  def create_player(player_number, player_color)
    print_player_name_prompt(player_number)
    player_name = player_name_input

    Player.new(player_name, player_color, @board)
  end

  def create_board
    @board = Board.new
  end

  def play_turn
    @board.display

    print_piece_to_move_input(@current_player)
    piece = player_piece_input(@current_player.piece_positions, @board) # returns the piece object

    piece.mark_selected
    valid_moves = piece.valid_moves
    @board.add_valid_moves(valid_moves)
    @board.display

    print_piece_destination_input(valid_moves)
    destination = piece_destination_input(valid_moves)

    piece.mark_unselected
    @board.remove_valid_moves
    @board.move(piece, destination)
    print_king_in_check_message if @current_player_king.check?

    next_player
  end

  private

  def clear_screen
    system 'clear'
  end

  def set_current_player
    @current_player = @player1
    @current_player_king = @board.get_king(@current_player.color)
  end

  def next_player
    next_player = @current_player == @player1 ? @player2 : @player1
    @current_player = next_player
    @current_player_king = @board.get_king(@current_player.color)
  end

  def conclusion
    print_game_winner_message
  end
end
