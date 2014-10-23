
class Queen < SlidingPiece
  
  def initialize(pos, color, board)
    super(pos, color, board)
    @deltas = [[0, 1], [1, 1], [1, 0], [1, -1],
              [0, -1], [-1, -1], [-1, 0], [-1, 1]]
  end
end