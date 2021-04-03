require_relative '../modules/draw'
require_relative 'i_piece'
require_relative 'j_piece'
require_relative 'l_piece'
require_relative 'o_piece'
require_relative 's_piece'
require_relative 't_piece'
require_relative 'z_piece'

class GameBoard
  include Draw
  attr_reader :object_array, :current_piece, :next_piece

  def initialize(window, game_board_width = 20, game_board_height = 40)
    @window = window
    @game_board_width = game_board_width
    @object_array = Array.new(game_board_height) { [0] * @game_board_width }
    @position = {
      x: 0,
      y: 0
    }
    @lines_cleared = 0
    @level = 1
    @pieces = [IPiece, JPiece, LPiece, OPiece, SPiece, TPiece, ZPiece]
    assign_next_piece
    assign_next_piece
  end

  def create_piece
    @in_play = @current_piece.new(@object_array, @window)
  end

  def assign_next_piece
    @pieces -= [@next_piece]
    @pieces = [IPiece, JPiece, LPiece, OPiece, SPiece, TPiece, ZPiece] if @pieces.length.zero?

    @current_piece = @next_piece
    @next_piece = @pieces.sample
  end

  def calculate_level
    @level = (@lines_cleared / 10) + 1
  end

  def user_movement
    key = @window.getch
    case key
    when Curses::KEY_LEFT
      @in_play.move_left
    when Curses::KEY_RIGHT
      @in_play.move_right
    when Curses::KEY_UP
      @in_play.rotate
    when Curses::KEY_DOWN
      @in_play.hard_drop
    end
  end

  def fall(next_window, lines_window)
    create_piece
    display_next_piece(next_window)
    loop do
      start_time = Time.now
      calculate_level
      @speed = (0.8 - ((@level - 1) * 0.007))**(@level - 1)

      @window.erase
      @in_play.draw
      draw
      @window.noutrefresh

      unless @in_play.move_down((Time.now - start_time) / @speed)
        assign_next_piece
        create_piece
        display_next_piece(next_window)
        break unless @in_play.is_valid_position?
      end
      user_movement
      remove_lines
      display_lines(lines_window)

      Curses.doupdate

      sleep([0, (1 / 60) - (Time.now - start_time)].max)
    end
  end

  def remove_lines
    lines_to_delete = 0
    deleted_indexes = []
    @object_array.each_with_index do |line, i|
      next if line.include?(0)

      lines_to_delete += 1
      @lines_cleared += 1
      deleted_indexes << i
    end

    deleted_indexes.reverse.each { |i| @object_array.delete_at(i) }
    @object_array = Array.new(lines_to_delete) { [0] * @game_board_width } + @object_array
  end

  def display_next_piece(next_window)
    next_window.clear
    piece = @next_piece.new([[0] * next_window.maxx] * next_window.maxy, next_window)
    piece.position[:y] = (piece.board.length / 2) - (piece.object_array.length / 2)
    piece.position[:x] = (piece.board[0].length / 2) - (piece.object_array[0].length / 2)
    piece.draw
    next_window.noutrefresh
  end

  def display_lines(lines_window)
    lines = (@lines_cleared / 2).to_s
    lines_window.erase
    lines_window.setpos((lines_window.maxy / 2), (lines_window.maxx / 2) - (lines.length / 2).ceil)
    lines_window.addstr("#{lines}, #{@level}")
    lines_window.noutrefresh
  end
end
