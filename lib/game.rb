# frozen_string_literal: true

# Central to run the game itself
class Game
  include Check

  def initialize
    @board               = nil
    @player1             = nil
    @player2             = nil
    @current_player      = nil
    @current_player_king = nil
  end

  def play
    welcome_message
    create_players
    create_board
    play_turn until @current_player_king.check_mate?
    conclusion
  end

  def create_players
    @player1 = create_player(1, 'black')
    @player2 = create_player(2, 'white')
    @current_player = @player2
  end

  def create_player(player_number, player_color)
    puts display_player_name_prompt(player_number)
    player_name = player_name_input

    Player.new(player_name, player_color)
  end

  def play_turn
    clear_screen
    next_player
    board.display

    current = player_piece_input(player.name) # returns two coordinates (as an arr (ex: [3, 2]))
    piece = get_piece(current)
    valid_moves = piece.valid_moves

    destination = player_destination_input(player.name, valid_moves)
    board.move(piece, current, destination)

    display_king_in_check_message if @current_player_king.check?(board)
  end

  private

  def next_player
    next_player = @current_player == @player1 ? @player2 : @player1
    @current_player = next_player
    @current_player_king = board.get_king(next_player)
  end

  def clear_screen
    system 'clear'
  end

  def conclusion
    display_game_winner_message()
  end
end
