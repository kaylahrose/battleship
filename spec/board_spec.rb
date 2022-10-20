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
end
