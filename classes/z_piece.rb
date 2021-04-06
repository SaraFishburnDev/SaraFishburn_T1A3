require_relative 'game_piece'

class ZPiece < GamePiece
  def initialize(board, window)
    @object_array = [
      [7, 7, 7, 7, 0, 0],
      [7, 7, 7, 7, 0, 0],
      [0, 0, 7, 7, 7, 7],
      [0, 0, 7, 7, 7, 7],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ]
    super(board, window)
    @position[:y] = 0
  end

  def wall_kick_data
    {
      0 => {
        3 => [{ x: 1, y: 0 }, { x: 1, y: -1 }, { x: 0, y: 2 }, { x: 1, y: 2 }],
        1 => [{ x: -1, y: 0 }, { x: -1, y: -1 }, { x: 0, y: 2 }, { x: -1, y: 2 }]
      },
      1 => {
        0 => [{ x: 1, y: 0 }, { x: 1, y: 1 }, { x: 0, y: -2 }, { x: 1, y: -2 }],
        2 => [{ x: 1, y: 0 }, { x: 1, y: 1 }, { x: 0, y: -2 }, { x: 1, y: -2 }]
      },
      2 => {
        1 => [{ x: -1, y: 0 }, { x: -1, y: -1 }, { x: 0, y: 2 }, { x: -1, y: 2 }],
        3 => [{ x: 1, y: 0 }, { x: 1, y: -1 }, { x: 0, y: 2 }, { x: 1, y: 2 }]
      },
      3 => {
        2 => [{ x: -1, y: 0 }, { x: -1, y: 1 }, { x: 0, y: -2 }, { x: -1, y: -2 }],
        0 => [{ x: -1, y: 0 }, { x: -1, y: 1 }, { x: 0, y: -2 }, { x: -1, y: -2 }]
      }
    }
  end
end
