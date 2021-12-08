puts "let's play tic tac toe"

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

  #def reset_board
   # self.board = {
    #  row1: [0, 1, 2],
     # row2: [3, 4, 5],
      #row3: [6, 7, 8]
    #}
    #reset_state
    #draw_board
  #end

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
                   'win'
                 else
                   'in-game'
                 end
  end

  #def reset_state
   # self.state = 'blank'
  #end

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

# creates 2 player and 1 board object and draws board
def initialize_setup
  puts 'enter name1 >>'
  n1 = gets.chomp
  while true
    puts "#{n1} enter ur 1 CHAR LONG symbol (no numbers) >>"
    s1 = gets.chomp
    if s1.length != 1 || s1.to_i!=0
      puts 'Erroneous input! Try again...'
    else
      p1 = Player.new(n1, s1)
      break
    end
  end

  puts 'enter name2 >>'
  n2 = gets.chomp
  while true
    puts "#{n2} enter ur 1 CHAR LONG symbol and it cannot be #{s1} >>"
    s2 = gets.chomp
    if s2.length != 1 || s2 == s1 || s1.to_i!=0
      puts 'Erroneous input! Try again...'
    else
      p2 = Player.new(n2, s2, false)
      break
    end
  end

  game_board = Board.new
  game_board.draw_board
  return [p1, p2, game_board]
end

# plays 1 round of tic tac toe
def game
  choices=[] # keeps track of all choices made by both players
  p1, p2, game_board = initialize_setup
  while game_board.state != 'end' || game_board.state!='win'
    while p1.turn
      puts "#{p1.name} enter digit for where u want to place ur symbol"
      p1_choice = gets.chomp
      if p1_choice.to_i > 9 || p1_choice.to_i < 1 || choices.include?(p1_choice.to_i)
        puts 'Erroneous input! Try again...'
      else
        p1_choice = p1_choice.to_i
        game_board.edit_board(p1_choice, p1.symbol)
        choices.push(p1_choice)
        p1.change_turn
        p2.change_turn
        break
      end
    end
    if game_board.state == 'win'
      puts "game over"
      puts p1.turn==false ? "#{p1.name} won!" : "#{p2.name} won!"
      break
    end
    if game_board.state=='end'
      puts "game over"
      puts "It was a draw"
      break
    end
    while p2.turn
      puts "#{p2.name} enter digit for where u want to place ur symbol"
      p2_choice = gets.chomp
      if p2_choice.to_i > 9 || p2_choice.to_i < 1 || choices.include?(p2_choice.to_i)
        puts 'Erroneous input! Try again...'
      else
        p2_choice = p2_choice.to_i
        game_board.edit_board(p2_choice, p2.symbol)
        choices.push(p2_choice)
        p2.change_turn
        p1.change_turn
        break
      end
    end
    if game_board.state == 'win'
      puts "game over"
      puts p1.turn==false ? "#{p1.name} won!" : "#{p2.name} won!"
      break
    end
  end
  puts "press y/(any other key) to replay/exit"
  return gets.chomp.downcase
end

def main
  game
  while game=='y'
    game
  end
end

main