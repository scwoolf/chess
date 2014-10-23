#encoding: UTF-8

class Piece
  
  attr_accessor :pos, :color
  
  def initialize(pos, color, board)
    @pos, @color, @board = pos, color, board
    @board[@pos] = self
  end
  
  def opposite_color
    @color == "white" ? "black" : "white"
  end
  
  def valid_moves
    self.moves.select { |move| !move_into_check?(move) }     
  end
  
  
  def move_into_check?(pos)
    dup_board = @board.dup
    dup_board.move!(self.pos,pos)
    dup_board.in_check?(self.color) ? true : false
  end
  
  def inspect
      
    if self.color == "white"
      return "♔" if self.is_a?(King) 
      return "♕" if self.is_a?(Queen)
      return "♖" if self.is_a?(Rook)
      return "♗" if self.is_a?(Bishop)
      return "♘" if self.is_a?(Knight)
      return "♙" if self.is_a?(Pawn)
      
    elsif self.color == "black"
      return "♚" if self.is_a?(King) 
      return "♛" if self.is_a?(Queen)
      return "♜" if self.is_a?(Rook)
      return "♝" if self.is_a?(Bishop)
      return "♞" if self.is_a?(Knight)
      return "♟" if self.is_a?(Pawn)
      
    end
  end
end

class SlidingPiece < Piece
 
  def moves
    positions = []
    @deltas.each do |delta|
      next_pos = [pos[0] + delta[0], pos[1] + delta[1]]
      while next_pos[0].between?(0,7) && next_pos[1].between?(0,7)
        positions << next_pos unless @board[next_pos] && @board[next_pos].color == self.color
        break unless @board[next_pos].nil?
        next_pos = [next_pos[0] + delta[0], next_pos[1] + delta[1]]
      end      
    end
    positions
  end
end

class SteppingPiece < Piece
  def moves
    positions = []
    @deltas.each do |delta|
      next_pos = [pos[0] + delta[0], pos[1] + delta[1]]
      if next_pos[0].between?(0,7) && next_pos[1].between?(0,7)
        positions << next_pos unless @board[next_pos] && @board[next_pos].color == self.color
      end
    end
    positions
  end
end