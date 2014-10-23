class Bishop < SlidingPiece
  def initialize(pos, color, board)
    super(pos, color, board)
    @deltas = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  end
end
