# frozen_string_literal: true

# Used for visually displaying valid moves to player
class ValidMove < Piece
  attr_reader :name, :character

  def initialize(color, position, board)
    @name = 'valid_move'
    @character = "\e[31m\u25CF\e[31m"
    super(color, position, board)
  end
end
