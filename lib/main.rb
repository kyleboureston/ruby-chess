# frozen_string_literal: true

require_relative 'conversions'
require_relative 'pieces/piece'
require_relative 'pieces/bishop'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/knight'
require_relative 'pieces/king'
require_relative 'pieces/pawn'
require_relative 'display/board'
require_relative 'display/messages'
require_relative 'input'
require_relative 'colors'
require_relative 'board'
require_relative 'player'
require_relative 'game'

Game.new.play
