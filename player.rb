#encoding: UTF-8

class Player
  attr_accessor :name
  attr_reader :color
  
  def initialize(color)
    @color = color
    @name = 'Player'
  end
  
end