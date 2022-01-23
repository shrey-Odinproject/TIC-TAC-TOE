# this class deals with player in game
class Player
  attr_accessor :symbol, :name, :turn

  def initialize(nam = nil, sym = nil, trn = true)
    @name = nam
    @symbol = sym
    @turn = trn
  end

  def switch_turn
    @turn = !@turn
  end

  def setup_p1
    self.name = ask_plyr_name(1)
    loop do
      sym = validate_symbol(ask_p1_symbol(name))
      self.symbol = sym
      break if sym

      puts 'Erroneous input! Try again...'
    end
  end

  def setup_p2(p1_sym)
    self.name = ask_plyr_name(2)
    switch_turn # pl2 is false and p1 is true and then they rotate
    loop do
      sym = validate_symbol(ask_p2_symbol(name, p1_sym), p1_sym)
      self.symbol = sym
      break if sym

      puts 'Erroneous input! Try again...'
    end
  end

  def validate_symbol(sym, p1_sym = nil) # for p1 p1_sym doesnt exist yet so nil
    return sym unless sym.length != 1 || sym.to_i != 0 || sym == p1_sym
  end

  private

  def ask_plyr_name(plyr_num)
    puts "enter name for player #{plyr_num} >>"
    gets.chomp
  end

  def ask_p1_symbol(name)
    puts "#{name} enter ur 1 CHAR LONG symbol (no numbers) >>"
    gets.chomp
  end

  def ask_p2_symbol(name, p1_sym)
    puts "#{name} enter ur 1 CHAR LONG symbol (no numbers) , it cannot be #{p1_sym} >>"
    gets.chomp
  end
end
