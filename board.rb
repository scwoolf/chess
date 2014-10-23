#encoding: UTF-8

class Board
  
  attr_accessor :grid
  
  def initialize
    @positions = (0..7).to_a.product((0..7).to_a)
    @grid = Array.new(8) {Array.new(8)}
  end
  
  def [](pos)
    x, y = pos
    @grid[7-y][x]
  end
  
  def []=(pos, obj)
    x, y = pos
    @grid[7-y][x] = obj
  end
  
  def checkmate?(color)
  
    if self.in_check?(color)
      possible_moves = []
      @positions.each do |pos|
        possible_moves += self[pos].valid_moves if self[pos] && self[pos].color == color
      end
      possible_moves.length == 0 ? true : false
     end
  end
  
  def in_check?(color)  
   
    enemy_moves, king_pos = [], []

    @positions.each do |pos|
      unless self[pos].nil?
        enemy = self[pos] if self[pos].opposite_color == color
        enemy_moves += enemy.moves if enemy
        king_pos = pos if self[pos].is_a?(King) && self[pos].color == color
      end
    end
    
    enemy_moves.include?(king_pos) ? true : false
  end
    
  def move!(start, end_pos)
    if !self[start].nil? && self[start].moves.include?(end_pos) 
      self[end_pos], self[start].pos, self[start] = self[start], end_pos, nil
    end
  end
  
  def move(start, end_pos)
    move!(start, end_pos) if self[start].valid_moves.include?(end_pos)
  end
  
  def dup
    dup_board = Board.new
    
    @positions.each do |pos|
      unless self[pos].nil?
        dup_board[pos] = self[pos].class.new(pos, self[pos].color, dup_board)
      end
    end
    dup_board
  end
  
  def render
    (0..7).each do |row|
      y = 7 - row
     row_str = "#{y}|"
      (0..7).each do |col|
        
        x, el_str = col, ''
        if self[[x,y]].nil?
          el_str = "_"
        else
          el_str = self[[x,y]].inspect
        end
        row_str += el_str + ' |'
      end
      puts row_str
    end
    puts "  0  1  2  3  4  5  6  7 "
  end
  
  def promotion?
    @positions.each do |pos|
      if self[pos].is_a?(Pawn)    
        return true if pos[1] == 7 && self[pos].color == "white"
        return true if pos[1] == 0 && self[pos].color == "black"
      end  
    end
    false
  end
end
