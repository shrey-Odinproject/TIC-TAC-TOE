# frozen_string_literal:true

require './lib/player'

describe Player do
  describe '#switch_turn' do
    subject(:player) { described_class.new }

    it 'inverts boolean value of @turn' do
      expect { player.switch_turn }.to change { player.turn }.to(!player.turn)
    end
  end
end
