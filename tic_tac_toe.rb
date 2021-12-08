puts "let's play tic tac toe"

# this class deals with game board
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

  def reset_board
    self.board = {
      row1: [0, 1, 2],
      row2: [3, 4, 5],
      row3: [6, 7, 8]
    }
    reset_state
    draw_board
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
    # changes state to end once there are no numbers left in data structure or if won? is true
    self.state = if board.values.flatten.none? { |num| num == num.to_i }
                   'end'
                 elsif won?
                   'end'
                 else
                   'in-game'
                 end
  end

  def reset_state
    self.state = 'blank'
  end

  def all_equal?(arr)
    # returns true if all elm in array are same
    arr.uniq.size <= 1
  end
end

# this class deals with player in game
class Player
  attr_reader :symbol, :name, :turn

  def initialize(nam = nil, sym = nil, trn = true)
    @name = nam
    @symbol = sym
    @turn = trn
  end

  def change_turn
    @turn = !@turn
  end
end
# p1=Player.new('shrey','&',true)

def initialize_setup
  puts 'enter name1 >>'
  n1 = gets.chomp
  while true
    puts "#{n1} enter ur symbol >>"
    s1 = gets.chomp
    if s1.length != 1
      puts 'Erroneous input! Try again...'
    else
      p1 = Player.new(n1, s1)
      break
    end
  end

  puts 'enter name2 >>'
  n2 = gets.chomp
  while true
    puts "#{n2} enter ur symbol and it cannot be #{s1}>>"
    s2 = gets.chomp
    if s2.length != 1 || s2==s1
      puts 'Erroneous input! Try again...'
    else
      p2 = Player.new(n2, s2,false)
      break
    end
  end

  game_board = Board.new
  game_board.draw_board
end

initialize_setup
