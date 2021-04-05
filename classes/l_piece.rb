require_relative 'game_piece'

class LPiece < GamePiece
  def initialize(board, window)
    @object_array = [
      [0, 0, 0, 0, 3, 3],
      [0, 0, 0, 0, 3, 3],
      [3, 3, 3, 3, 3, 3],
      [3, 3, 3, 3, 3, 3],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ]
    super(board, window)
    @position[:x] -= 2
    @position[:y] = 0
  end

  def wall_kick_data
    {
      0 => {
        3 => [{ x: 1, y: 0 }, { x: 1, y: 1 }, { x: 0, y: -2 }, { x: 1, y: -2 }],
        1 => [{ x: -1, y: 0 }, { x: -1, y: 1 }, { x: 0, y: -2 }, { x: -1, y: -2 }]
      },
      1 => {
        0 => [{ x: 1, y: 0 }, { x: 1, y: -1 }, { x: 0, y: 2 }, { x: 1, y: 2 }],
        2 => [{ x: 1, y: 0 }, { x: 1, y: -1 }, { x: 0, y: 2 }, { x: 1, y: 2 }],
      },
      2 => {
        1 => [{ x: -1, y: 0 }, { x: -1, y: 1 }, { x: 0, y: -2 }, { x: -1, y: -2 }],
        3 => [{ x: 1, y: 0 }, { x: 1, y: 1 }, { x: 0, y: -2 }, { x: 1, y: -2 }],
      },
      3 => {
        2 => [{ x: -1, y: 0 }, { x: -1, y: -1 }, { x: 0, y: 2 }, { x: -1, y: 2 }],
        0 => [{ x: -1, y: 0 }, { x: -1, y: -1 }, { x: 0, y: 2 }, { x: -1, y: 2 }],
      }
    }
  end
end