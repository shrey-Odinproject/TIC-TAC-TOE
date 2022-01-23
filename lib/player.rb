# this class deals with player in game
class Player
  attr_reader :symbol, :name, :turn

  def initialize(nam = nil, sym = nil, trn = true)
    @name = nam
    @symbol = sym
    @turn = trn
  end

  def switch_turn
    @turn = !@turn
  end
end
