require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/gameplay'

RSpec.describe Gameplay do
  let(:gameplay) { Gameplay.new }

  it 'exists' do
    expect(gameplay.comp_board).to be_an_instance_of(Board)
    expect(gameplay.player_board).to be_an_instance_of(Board)
    expect(gameplay.comp_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.comp_submarine).to be_an_instance_of(Ship)
    expect(gameplay.player_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.player_submarine).to be_an_instance_of(Ship)
  end

  it 'sets up computer board' do
    gameplay.computer_setup
    expect(gameplay.comp_board.cells.count { |_coord, cell| cell.empty? == false }).to eq(5)
  end

  it 'fires at computers board' do
    gameplay.comp_board.cells['A1'].fire_upon
    expect(gameplay.comp_board.cells.count { |_coord, cell| cell.fired_upon? }).to eq(1)
  end

  it 'checks if computer won' do
    expect(gameplay.comp_win?).to eq(false)
    3.times { gameplay.player_cruiser.hit }
    3.times { gameplay.player_submarine.hit }
    expect(gameplay.comp_win?).to eq(true)
  end

  it 'checks if player won' do
    expect(gameplay.player_win?).to eq(false)
    3.times { gameplay.comp_cruiser.hit }
    3.times { gameplay.comp_submarine.hit }
    expect(gameplay.player_win?).to eq(true)
  end
end
