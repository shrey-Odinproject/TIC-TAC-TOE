puts "let's play tic tac toe"
digits_on_board=(0..8).to_a

def draw_board
  puts '1  | 2 |  3'
  puts '---+---+---'
  puts '4  | 5 |  6'
  puts '---+---+---'
  puts '7  | 8 |  9'
end

puts digits_on_board[3]
draw_board
