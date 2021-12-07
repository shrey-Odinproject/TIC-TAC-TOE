puts "let's play tic tac toe"
class Board
  attr_reader :state, :board

  def initialize
    @state = 'blank'
    @board = {
      row1: [0, 1, 2],
      row2: [3, 4, 5],
      row3: [6, 7, 8]
    }
  end

  def draw_board
    puts " #{board[:row1][0]} | #{board[:row1][1]} | #{board[:row1][2]} "
    puts '---+---+---'
    puts " #{board[:row2][0]} | #{board[:row2][1]} | #{board[:row2][2]} "
    puts '---+---+---'
    puts " #{board[:row3][0]} | #{board[:row3][1]} | #{board[:row3][2]} "
  end

  def edit_board(pos,sym)
    board.each do |key,val|
      val.each_with_index do |num,idx|
        if pos==num
          board[key][idx]=sym
        end
      end
    end
    draw_board
  end

end

game_board = Board.new
game_board.draw_board
puts
puts
game_board.edit_board(5,'$')
