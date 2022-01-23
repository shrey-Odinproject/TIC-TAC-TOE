# frozen_string_literal:true

# this class deals with game board
class Board
  attr_reader :state, :board

  def initialize
    @state = 'in-game'
    @board = {
      row1: [1, 2, 3],
      row2: [4, 5, 6],
      row3: [7, 8, 9]
    }
  end

  def draw_board
    puts " #{board[:row1][0]} | #{board[:row1][1]} | #{board[:row1][2]} "
    puts '---+---+---'
    puts " #{board[:row2][0]} | #{board[:row2][1]} | #{board[:row2][2]} "
    puts '---+---+---'
    puts " #{board[:row3][0]} | #{board[:row3][1]} | #{board[:row3][2]} "
  end

  def edit_board(pos, sym)
    board.each do |key, val|
      val.each_with_index do |num, idx|
        board[key][idx] = sym if pos == num
      end
    end
    # self.state = 'in-game' dont want to edit directly will use edit_state function
    draw_board
    edit_state
  end

  def won?
    board.each_value { |arr| return true if all_equal?(arr) } # goes over each row
    board.values.transpose.each { |arr| return true if all_equal?(arr) } # goes over each column
    return true if board[:row1][0] == board[:row2][1] && board[:row2][1] == board[:row3][2] # primary diagonal
    return true if board[:row1][2] == board[:row2][1] && board[:row2][1] == board[:row3][0] # secondary diagonal

    false # no above condition returned so no winner yet
  end

  protected

  attr_writer :state, :board

  def edit_state
    # changes state to end once there are no numbers left in data structure or to win if won? is true
    self.state = if won?
                   'win'
                 elsif board.values.flatten.none? { |num| num == num.to_i }
                   'end'
                 else
                   'in-game'
                 end
  end

  def all_equal?(arr)
    # returns true if all elm in array are same
    arr.uniq.size <= 1
  end
end
