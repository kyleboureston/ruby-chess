# frozen_string_literal: true

# Central to run the game itself
module Input
  def self.included(_base)
    include Display
  end

  private

  def player_destination_input
    destination = display_player_destination_input
    return destination if valid_moves.include?(desination)

    display_destination_warning
    player_destination_input(player.name, valid_moves)
  end
end