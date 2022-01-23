# frozen_string_literal:true

class Game
  attr_accessor :game_board, :p1, :p2, :choices

  def initialize
    @game_board = Board.new
    @p1, @p2 = setup_players
    @choices = [] # keeps track of all choices made by both players so 2 players cant input on same spot
  end

  def setup_players
    puts 'enter name1 >>'
    n1 = gets.chomp
    while true
      puts "#{n1} enter ur 1 CHAR LONG symbol (no numbers) >>"
      s1 = gets.chomp
      if s1.length != 1 || s1.to_i != 0
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
      if s2.length != 1 || s2 == s1 || s2.to_i != 0
        puts 'Erroneous input! Try again...'
      else
        p2 = Player.new(n2, s2, false)
        break
      end
    end

    [p1, p2]
  end

  # asks for input to player and edits board
  def get_input(p1, p2, game_board, choices)
    while p1.turn
      puts "#{p1.name} enter digit for where u want to place ur symbol"
      p1_choice = gets.chomp
      if p1_choice.to_i > 9 || p1_choice.to_i < 1 || choices.include?(p1_choice.to_i)
        puts 'Erroneous input! Try again...'
      else
        p1_choice = p1_choice.to_i
        game_board.edit_board(p1_choice, p1.symbol)
        choices.push(p1_choice)
        p1.switch_turn
        p2.switch_turn
        break
      end
    end
  end

  # plays 1 round of tic tac toe
  def play
    game_board.draw_board
    while true
      # check if game ends after every input
      get_input(p1, p2, game_board, choices) # 1st player input

      break if game_end?(game_board, p1, p2) # check if game ending condition becomes true

      get_input(p2, p1, game_board, choices) # 2nd player input

      break if game_end?(game_board, p1, p2)
    end
  end

  def game_end?(game_board, p1, p2)
    # checks to see if gameboard state is win/end so we can stop game and display final message
    if game_board.state == 'win'
      puts "game over"
      puts p1.turn == false ? "#{p1.name} won!" : "#{p2.name} won!"
      true
    elsif game_board.state == 'end'
      puts "game over"
      puts "It was a draw"
      true
    end
  end
end
