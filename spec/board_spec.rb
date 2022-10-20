require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  it 'exists' do
    # require 'pry'; binding.pry
    board = Board.new
    # require 'pry'; binding.pry

    expect(board).to be_an_instance_of(Board)
  end

  it 'has an hash of cells' do
    board = Board.new

    # It’s a hash, it should have 16 key/value pairs, and those keys point to cell objects.
    expect(board.cells).to be_an_instance_of(Hash)
    expect(board.cells.keys.length).to eq(16)
    board.cells.values.each { |cell| expect(cell).to be_an_instance_of(Cell)}
  end


  it 'validates coordinates' do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to eq(true)
    # require 'pry'; binding.pry
    expect(board.valid_coordinate?("D4")).to eq(true)
    # require 'pry'; binding.pry
    expect(board.valid_coordinate?("A5")).to eq(false)
    # require 'pry'; binding.pry
    expect(board.valid_coordinate?("E1")).to eq(false)
    # require 'pry'; binding.pry
    expect(board.valid_coordinate?("A22")).to eq(false)
    # require 'pry'; binding.pry
  end

  it 'validates placement by array length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    # expect the number of coordinates in the array should be the same as the length of the ship
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
  end

  it 'validates placement with consecutive coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
  end
end
