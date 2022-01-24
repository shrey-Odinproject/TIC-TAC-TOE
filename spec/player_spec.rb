# frozen_string_literal:true

require './lib/player'

describe Player do
  describe '#switch_turn' do
    subject(:player) { described_class.new }

    it 'inverts boolean value of @turn' do
      expect { player.switch_turn }.to change { player.turn }.to(!player.turn)
    end
  end

  describe '#setup_p1' do
    subject(:playa) { described_class.new }

    context 'when input entered is valid' do
      before do
        name = 'abcd'
        valid = '!'
        allow(playa).to receive(:ask_plyr_name).with(1).and_return(name)
        allow(playa).to receive(:ask_p1_symbol).with(name).and_return(valid)
        # allow(playa).to receive(:validate_symbol).with(valid).and_return(valid)
      end

      it 'does not display error msg' do
        expect(playa).not_to receive(:puts).with('Erroneous input! Try again...')
        playa.setup_p1
      end
    end

    context 'when 3 invalid and 1 valid input' do
      before do
        name = 'abcd'
        invalid1 = '2'
        invalid2 = '@#'
        invalid3 = '10'
        valid = '!'
        allow(playa).to receive(:ask_plyr_name).with(1).and_return(name)
        allow(playa).to receive(:ask_p1_symbol).with(name).and_return(invalid1, invalid2, invalid3, valid)
      end
      it 'displays error msg thrice' do
        expect(playa).to receive(:puts).with('Erroneous input! Try again...').thrice
        playa.setup_p1
      end
    end
  end

  describe '#setup_p2' do
    subject(:playa) { described_class.new }
    p1_sym = '!'
    context 'when input entered is valid' do
      before do
        name = 'abcd'
        valid = '^'
        allow(playa).to receive(:ask_plyr_name).with(2).and_return(name)
        allow(playa).to receive(:ask_p2_symbol).with(name, p1_sym).and_return(valid)
      end

      it 'does not display error msg' do
        expect(playa).not_to receive(:puts).with('Erroneous input! Try again...')
        playa.setup_p2(p1_sym)
      end
    end

    context 'when 2 invalid,p1_symbol and 1 valid input' do
      before do
        name = 'abcd'
        invalid1 = '2'
        invalid2 = '@#'
        valid = '^'
        allow(playa).to receive(:ask_plyr_name).with(2).and_return(name)
        allow(playa).to receive(:ask_p2_symbol).with(name, p1_sym).and_return(invalid1, invalid2, p1_sym, valid)
      end
      it 'displays error msg thrice' do
        expect(playa).to receive(:puts).with('Erroneous input! Try again...').thrice
        playa.setup_p2(p1_sym)
      end
    end
  end

  describe '#validate_symbol' do
    subject(:player_symbol) { described_class.new }
    context 'when input lenght>1' do
      it 'returns nil' do
        sym = 'abvd'
        tst = player_symbol.validate_symbol(sym)
        expect(tst).to be_nil
      end
    end

    context 'when inputting a number' do
      it 'returns nil' do
        sym = '3'
        tst = player_symbol.validate_symbol(sym)
        expect(tst).to be_nil
      end
    end

    context 'for pl2 if u enter same symbol as that of pl1_symbol' do
      it 'returns nil' do
        sym = '@'
        pl2_sym = '@'
        tst = player_symbol.validate_symbol(sym, pl2_sym)
        expect(tst).to be_nil
      end
    end

    context 'when symbol is valid' do
      it 'returns symbol' do
        sym = 'X'
        tst = player_symbol.validate_symbol(sym)
        expect(tst).to eq(sym)
      end
    end
  end
end
