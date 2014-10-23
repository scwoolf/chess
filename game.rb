#encoding: UTF-8

class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    
    @board.grid.each_index do |row|
      y = 7 - row
      set_row(y, @board) if [0,1,6,7].include?(y)
      
    @white = Player.new("white")
    @black = Player.new("black")
    end
  end
  
  def set_row(y, board)
    color = "white" if y == 0 || y == 1
    color = "black" if y == 7 || y == 6
    
    if y == 0 || y == 7
      Rook.new([0,y], color, board)
      Knight.new([1,y], color, board)
      Bishop.new([2,y], color, board)
      Queen.new([3,y], color, board)
      King.new([4,y], color, board)
      Bishop.new([5,y], color, board)
      Knight.new([6,y], color, board)
      Rook.new([7,y], color, board)
      
    elsif y == 1 || y == 6
      8.times do |x|
        Pawn.new([x,y], color, board)
      end
    end
  end
    
  def play
    puts "Who is playing white?"
    @white.name = gets.chomp
    puts "Who is playing black?"
    @black.name = gets.chomp

    current_player = @white
    until @board.checkmate?(current_player.color)
      @board.render
      start_pos, end_pos = turn(current_player)
      @board.move(start_pos, end_pos)
      @board[end_pos].promote if @board.promotion?
      current_player = switch_player(current_player)
    end
    @board.render
    puts "CHECKMATE!!!!!!!!!!"
  end
  
  def turn(player)
    puts "#{player.name.upcase} IS IN CHECK!!!" if @board.in_check?(player.color)
    start_pos, end_pos = [], []
    
    loop do
      puts "#{player.name}'s turn. Select piece, separate x and y with space"
      start_pos = gets.chomp.split(" ").map(&:to_i)
      unless @board[start_pos] && @board[start_pos].color == player.color
        puts "You can't select that! Try again."
        next
      end
      break
    end
    
    puts "Select end location, separate x and y with space"
    end_pos = gets.chomp.split(" ").map(&:to_i)
    unless @board[start_pos].valid_moves.include?(end_pos) 
      puts "Invalid move! Try again."
      start_pos, end_pos = turn(player)  
    end
    [start_pos,end_pos]
  end
  
  def switch_player(player)
    player = (player == @white ? @black : @white)
  end
  
end