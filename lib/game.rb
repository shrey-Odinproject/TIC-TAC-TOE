# frozen_string_literal:true

require './lib/player'
class Game
  attr_accessor :game_board, :p1, :p2, :choices

  def initialize
    @game_board = Board.new
    @p1, @p2 = setup_players
    @choices = [] # keeps track of all choices made by both players so 2 players cant input on same spot
  end

  def setup_players
    plyr1 = Player.new
    plyr1.setup_p1

    plyr2 = Player.new
    plyr2.setup_p2(plyr1.symbol)

    [plyr1, plyr2]
  end

  # asks for input to player and edits board
  def get_input(plyr, other_player)
    while plyr.turn
      plyr_choice = ask_move(plyr)
      unless valid_move?(plyr_choice)
        puts 'Erroneous input! Try again...'
      else
        update_board(plyr_choice, plyr.symbol)
        swap_turns(plyr, other_player)
        break
      end
    end
  end

  def ask_move(plyr)
    puts "#{plyr.name} enter digit for where u want to place ur symbol"
    gets.chomp.to_i
  end

  def valid_move?(choice)
    true unless choice > 9 || choice < 1 || choices.include?(choice)
  end

  def update_board(choice, symbol)
    game_board.edit_board(choice, symbol)
    choices.push(choice)
  end

  def swap_turns(plyr, other_player)
    plyr.switch_turn
    other_player.switch_turn
  end

  # plays 1 round of tic tac toe
  def play
    game_board.draw_board
    while true
      # check if game ends after every input
      get_input(p1, p2) # 1st player input

      break if game_end? # check if game ending condition becomes true

      get_input(p2, p1) # 2nd player input

      break if game_end?
    end
  end

  def game_end?
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
