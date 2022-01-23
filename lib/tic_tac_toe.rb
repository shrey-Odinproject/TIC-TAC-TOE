# frozen_string_literal:true

require './lib/game'
require './lib/board'
require './lib/player'

# play multiple rounds until u wanna exit
def main
  loop do
    puts "let's play tic tac toe"
    g = Game.new
    g.play
    # after game over ask to replay
    puts 'press y/(any other key) to replay/exit'
    replay_input = gets.chomp.downcase
    break if replay_input != 'y'
  end
end

main
