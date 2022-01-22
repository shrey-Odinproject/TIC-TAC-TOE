require './lib/tic_tac_toe.rb'

describe Board do
  
  describe '#won?' do
    subject(:board_win) {described_class.new}
    let(:board) {board_win.instance_variable_get(:@board)}
    context 'when all in a row' do
      it 'returns true' do
        board[:row3]=['X','X','X']
        expect(board_win).to be_won 
      end
    end

    context 'when all in a column'do
      it 'returns true' do
        board[:row1][1]='O'
        board[:row2][1]='O'
        board[:row3][1]='O'
        expect(board_win).to be_won
      end
    end

    context 'when all in main diagonal'do
      it 'returns true' do
        board[:row1][0] ='O'
        board[:row2][1] ='O'
        board[:row3][2] ='O'
        expect(board_win).to be_won
      end
    end

    context 'when all in second diagonal'do
      it 'returns true' do
        board[:row1][2] ='X'
        board[:row2][1] ='X'
        board[:row3][0] ='X'
        expect(board_win).to be_won
      end
    end

    context 'when no 3 in a row/col/diagonal'do
      it 'returns false' do
        board[:row1][2] ='X'
        board[:row2][1] ='O'
        board[:row3][0] ='X'
        expect(board_win).not_to be_won
      end
    end

  end

  describe '#edit_board' do
    
  end
end