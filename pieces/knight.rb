
class Knight < SteppingPiece
  def initialize(pos, color, board)
    super(pos, color, board)
    @deltas = [[1, 2], [2, 1], [2, -1], [1, -2], 
              [-1, -2], [-2, -1], [-2, 1], [-1, 2]]
  end
end
