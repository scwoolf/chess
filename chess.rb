#encoding: UTF-8

require './piece.rb'
require './board.rb'
require './game.rb'
require './player.rb'

require_relative './pieces/pawn.rb'
require_relative './pieces/king.rb'
require_relative './pieces/queen.rb'
require_relative './pieces/bishop.rb'
require_relative './pieces/knight.rb'
require_relative './pieces/rook.rb'

g = Game.new
g.play


