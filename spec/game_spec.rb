# frozen_string_literal:true
require './lib/game'
require './lib/board'
require './lib/player'
describe Game do
  describe '#initialize' do
    # no testing needed ig
  end
  
  # describe '#get_input' do
  #   subject(:game) {described_class.new}
  #   let(:p1) {instance_double(Player)}
  #   let(:p2) {instance_double(Player)}
  #   let(:board) {instance_double(Board)}
  #   context 'when inputting correct choice' do
      
  #     before do
  #       choice='7'
  #       choices=[]
  #       allow(p1).to receive(:symbol)
  #       allow(board).to receive(:edit_board).with(choice,p1.symbol)
  #       allow(choices).to receive(:push).with(choice)
  #     end

  #     it 'doesnot puts error'do
  #       choice='7'
  #       choices=[]
  #       expect(board).to receive(:edit_board).with(choice,p1.symbol)
  #       expect(game).not_to receive(:puts).with('Erroneous input! Try again...')
  #       expect(choices).to receive(:push).with(choice)
  #       game.get_input(p1,p2,board,choices)
  #     end
  #   end
    
  # end
  
end