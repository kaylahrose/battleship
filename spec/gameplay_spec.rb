require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/gameplay'

RSpec.describe Gameplay do
  let(:gameplay) { Gameplay.new }

  xit 'exists' do
    expect(gameplay.comp_board).to be_an_instance_of(Board)
    expect(gameplay.player_board).to be_an_instance_of(Board)
    expect(gameplay.comp_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.comp_submarine).to be_an_instance_of(Ship)
    expect(gameplay.player_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.player_submarine).to be_an_instance_of(Ship)
  end

  it 'sets up computer board' do
    gameplay.computer_setup
    expect(gameplay.comp_board.cells.count { |coord, cell| cell.empty? == false }).to eq(5)
  end

  xit 'validates cruiser placement' do
    gameplay.computer_setup
    gameplay.validate_cruiser(("slajfk").split)
    expect(gameplay.validate_cruiser(("alksjd").split)).to eq("invalid, please try again")
    expect(gameplay.validate_cruiser(("a5").split)).to eq("invalid, please try again")
  end

  it 'fires at computers board' do
    gameplay.comp_board.cells["A1"].fire_upon
    expect(gameplay.comp_board.cells.count { |coord, cell| cell.fired_upon?}).to eq(1)
  end

  xit 'validates coordinate' do

  end

  it 'checks if computer won' do
    expect(gameplay.comp_win?).to eq(false)
    3.times {gameplay.player_cruiser.hit}
    3.times {gameplay.player_submarine.hit}
    expect(gameplay.comp_win?).to eq(true)
  end

  xit 'returns shot confirmation string' do
    gameplay.comp_board.place(gameplay.comp_cruiser, ["A1", "A2", "A3"])
    expect(gameplay.hit_or_miss_comp("A4")).to eq('was a miss')
  end
end
