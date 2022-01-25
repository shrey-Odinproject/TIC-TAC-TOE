# frozen_string_literal:true

require './lib/game'
require './lib/board'
# require './lib/player'

describe Game do
  describe '#initialize' do
    # no testing needed ig
  end

  describe '#valid_move?' do
    subject(:game_valid) { described_class.new }

    context 'when entering a num >9 or num <1' do
      before do
        allow(game_valid).to receive(:setup_players)
      end

      it 'returns false' do
        choice = 12
        tst = game_valid.valid_move?(choice)
        expect(tst).to be false
      end
      it 'returns false' do
        choice = 0
        tst = game_valid.valid_move?(choice)
        expect(tst).to be false
      end
    end

    context 'when inputting an already filled out space' do
      before do
        choices = game_valid.instance_variable_get(:@choices)
        choices.push(3)
        allow(choices).to receive(:include?).with(3).and_return(true)
      end
      it 'returns false' do
        choice = 3
        tst = game_valid.valid_move?(choice)
        expect(tst).to be false
      end
    end
  end

  describe '#update_board' do
    # incomming command so make assertion about direct public change
    subject(:game_update) { described_class.new }

    it ' appends choice to choices ' do
      choices = game_update.instance_variable_get(:@choices)
      choice = 3
      sym = '*'
      expect { game_update.update_board(choice, sym) }.to change { choices }.from([]).to([choice])
    end

    it 'edits game_board' do
      game_board = game_update.instance_variable_get(:@game_board).board
      choice = 3
      sym = '*'
      expect { game_update.update_board(choice, sym) }.to change { game_board[:row1][2] }.from(choice).to(sym)
    end
  end

  describe '#swap_turns' do
    # outgoing command msg
    subject(:game_turn) { described_class.new }
    let(:p1) { instance_double(Player) }
    let(:p2) { instance_double(Player) }

    it 'flips turn for both players' do
      expect(p1).to receive(:switch_turn)
      expect(p2).to receive(:switch_turn)
      game_turn.swap_turns(p1, p2)
    end
  end

  describe '#get_input' do
    # looping script method
    subject(:game_input) { described_class.new }
    let(:p1) { instance_double(Player) }
    let(:p2) { instance_double(Player) }

    context 'when valid choice entered' do
      before do
        allow(p1).to receive(:turn).and_return(true)
        allow(game_input).to receive(:ask_move).and_return(2)
        allow(game_input).to receive(:valid_move?).and_return(true)
        # allow(game_input).to receive(:update_board)
        # allow(game_input).to receive(:swap_turns)
        allow(p1).to receive(:symbol).and_return('@')
      end
      it 'does not puts an error msg' do
        expect(game_input).not_to receive(:puts).with('Erroneous input! Try again...')
        expect(game_input).to receive(:update_board).with(2, '@').once
        expect(game_input).to receive(:swap_turns).with(p1, p2).once
        game_input.get_input(p1, p2)
      end
    end

    context 'when entered 2 invalid and then 1 valid choice' do
      before do
        choices = game_input.instance_variable_get(:@choices)
        choices.push(5)
        allow(p1).to receive(:turn).and_return(true)
        allow(game_input).to receive(:ask_move).and_return(12, 5, 3)
        allow(game_input).to receive(:valid_move?).and_return(false, false, true)
        allow(p1).to receive(:symbol).and_return('@')
      end
      it 'puts error msg twice' do
        expect(game_input).to receive(:puts).with('Erroneous input! Try again...').twice
        expect(game_input).to receive(:update_board).with(3, '@').once
        expect(game_input).to receive(:swap_turns).with(p1, p2).once
        game_input.get_input(p1, p2)
      end
    end
  end

  # describe '#game_end' do
  #   subject(:game_obj) { described_class.new }
  #   let(:p1) { instance_double(Player) }
  #   let(:p2) { instance_double(Player) }
  #   let(:gb) {instance_double(Board)}

  #   context 'when board state is win & p1 has won' do
  #     before do
  #       allow(gb).to receive(:state).and_return('win')
  #       allow(p1).to receive(:turn).and_return(false)
  #       allow(p1).to receive(:name).and_return('shrey')
  #     end

  #     it 'puts victory msg for p1' do
  #       expect(game_obj).to receive(:puts).with('game over').once
  #       expect(game_obj).to receive(:puts).with('shrey won!').once
  #       game_obj.game_end
  #     end
  #   end
  # end

  describe '#play' do
    # looping script
    # test methods inside it
  end
end
