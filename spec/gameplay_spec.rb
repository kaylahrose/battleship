require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/gameplay'

RSpec.describe Gameplay do
  before(:each) do
    @gameplay = Gameplay.new
  end

  it 'exists' do
    gameplay = Gameplay.new

    expect(gameplay.comp_board).to be_an_instance_of(Board)
    expect(gameplay.player_board).to be_an_instance_of(Board)
    expect(gameplay.comp_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.comp_submarine).to be_an_instance_of(Ship)
    expect(gameplay.player_cruiser).to be_an_instance_of(Ship)
    expect(gameplay.player_submarine).to be_an_instance_of(Ship)
    # expect(gameplay.menu).to eq("Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.")
  end

  it 'sets up boards' do
    @gameplay.setup

    expect(@gameplay.comp_board.cells.count { |coord, cell| ship_present? == true }).to eq(5)
  end

  it 'validates shots' do
    # expect 'invalid, please try again',
    # expect 'This cell has been fired upon, please try again'
    # expect cell fired_upon == false
    # expect cell fired_upon == true
    @gameplay.setup
    expect(@gameplay.validate_shot("alksjd")).to eq("invalid, please try again")
    expect(@gameplay.validate_shot("a5")).to eq("invalid, please try again")


    # expect(@gameplay.validate_shot("alksjd")).to eq("invalid, please try again")



  end

  it 'shoots at players board' do
    expect(@gameplay.player_board.cells.count { |coord, cell| cell.fired_upon?}).to eq(0)
    @gameplay.computer_shot("A1")

  end
end
