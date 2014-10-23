class Pawn < Piece
  def initialize(pos, color, board)
    super(pos, color, board)
    
    @white_delta, @white_diags  = [0, 1], [[-1, 1], [1, 1]]
    @black_delta, @black_diags  = [0, -1], [[-1, -1], [1, -1]]
  end
    
  def moves
  positions=[]
  
  delta, diags = self.delta_by_color
  next_pos = [pos[0] + delta[0], pos[1] + delta[1]]
  if @board[next_pos].nil?
    positions << next_pos
    next_pos = [next_pos[0] + delta[0], next_pos[1] + delta[1]]
    if @board[next_pos].nil? && self.first_row == pos[1]
      positions << next_pos
    end
  end
  
  diags.each do |diag|
    next_pos = [pos[0] + diag[0], pos[1] + diag[1]]
    positions << next_pos if @board[next_pos] &&
      @board[next_pos].opposite_color == self.color
  end
  
  positions  
  end
  
  def delta_by_color
    delta, diags = @white_delta, @white_diags if self.color == "white"
    delta, diags = @black_delta, @black_diags if self.color == "black"
    [delta, diags]
  end
  
  def first_row
    return 1 if self.color == "white"
    return 6 if self.color == "black"
  end
  

  def promote
    puts "Promote pawn to which piece? [Q, B, K, or R]"
    promotion = gets.chomp
    if promotion == "Q"
      @board[self.pos] = Queen.new(self.pos, self.color, @board)
    elsif promotion == "B"
      @board[self.pos] = Bishop.new(self.pos, self.color, @board)
    elsif promotion == "K"
      @board[self.pos] = Knight.new(self.pos, self.color, @board)
    elsif promotion == "R"
      @board[self.pos] = Rook.new(self.pos, self.color, @board)
    else
      puts "Invalid choice. Try again."
      promote
    end

  end
 
  
end
