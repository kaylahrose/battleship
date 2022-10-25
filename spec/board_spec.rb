require './lib/ship'
require './lib/cell'
require './lib/board'

RSpec.describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_an_instance_of(Board)
  end

  it 'has a hash of cells' do
    board = Board.new

    # It’s a hash, it should have 16 key/value pairs, and those keys point to cell objects.
    expect(board.cells).to be_an_instance_of(Hash)
    expect(board.cells.keys.length).to eq(16)
    board.cells.values.each { |cell| expect(cell).to be_an_instance_of(Cell) }
  end

  it 'validates coordinates in 4x4 grid' do
    board = Board.new

    expect(board.valid_coordinate?('A1')).to eq(true)
    expect(board.valid_coordinate?('D4')).to eq(true)
    expect(board.valid_coordinate?('A5')).to eq(false)
    expect(board.valid_coordinate?('E1')).to eq(false)
    expect(board.valid_coordinate?('A22')).to eq(false)
  end

  it 'validates placement by array length' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)

    # expect the number of coordinates in the array should be the same as the length of the ship
    expect(board.valid_placement?(cruiser, %w[A1 A2])).to eq(false)
    expect(board.valid_placement?(submarine, %w[A2 A3 A4])).to eq(false)
    expect(board.valid_placement_array_length?(cruiser, %w[A1 A2])).to eq(false)
    expect(board.valid_placement_array_length?(submarine, %w[A2 A3 A4])).to eq(false)
    expect(board.valid_placement_array_length?(submarine, %w[A2 A3])).to eq(true)

    
  end

  it 'validates placement with consecutive coordinates' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    board.valid_placement?(cruiser, %w[A1 A2 A4])

    expect(board.valid_placement?(cruiser, %w[A1 A2 A4])).to eq(false)
    expect(board.valid_placement?(submarine, %w[A1 C1])).to eq(false)
    expect(board.valid_placement?(cruiser, %w[A3 A2 A1])).to eq(false)
    expect(board.valid_placement?(submarine, %w[C1 B1])).to eq(false)

    expect(board.consecutive_coordinates?(%w[A1 A2 A4])).to eq(false)
    expect(board.consecutive_coordinates?(%w[A1 C1])).to eq(false)
    expect(board.consecutive_coordinates?(%w[A3 A2 A1])).to eq(false)
    expect(board.consecutive_coordinates?(%w[C1 B1])).to eq(false)
  end

  it 'separates coordinates' do
    board = Board.new
    board.separate_coordinates(["A1", "A2"])
    # require 'pry'; binding.pry  
    expect(board.letter).to eq(["A", "A"])
  end

  it 'returns if coordinates are consecutive by number' do
    board = Board.new
    board.separate_coordinates(["A1", "A2"])
    expect(board.consec_coord_num?).to eq(true)
    board.separate_coordinates(["A2", "B2"])
    expect(board.consec_coord_num?).to eq(false)
  end

  it 'returns if coordinates are consecutive by letter' do
    board = Board.new
    board.separate_coordinates(["A1", "A2"])
    expect(board.consec_coord_letter?).to eq(false)
    board.separate_coordinates(["A2", "B2"])
    expect(board.consec_coord_letter?).to eq(true)
  end

  it 'validates placement no diagonal coordinates' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)

    expect(board.valid_placement?(cruiser, %w[A1 B2 C3])).to eq(false)
    expect(board.valid_placement?(submarine, %w[C2 D3])).to eq(false)
  end

  it 'validates placement example true' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)

    expect(board.valid_placement?(cruiser, %w[B1 C1 D1])).to eq(true)
    expect(board.valid_placement?(submarine, %w[A1 A2])).to eq(true)
    expect(board.valid_placement?(cruiser, %w[A1 A4 A3])).to eq(false)
    expect(board.valid_placement?(cruiser, %w[A1 D1 C1])).to eq(false)
  end

  # placing_ships interaction pattern
  it 'places cruiser on board' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])

    cell_1 = board.cells['A1']
    cell_2 = board.cells['A2']
    cell_3 = board.cells['A3']

    expect(cell_1.ship).to be_an_instance_of(Ship)
    expect(cell_2.ship).to be_an_instance_of(Ship)
    expect(cell_3.ship).to be_an_instance_of(Ship)

    expect(board.place(cruiser, %w[A1 A4 A3])).to eq(false)
  end

  it 'checks if same ship on different cells' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    cell_1 = board.cells['A1']
    cell_2 = board.cells['A2']
    cell_3 = board.cells['A3']

    expect(cell_3.ship == cell_2.ship).to eq(true)
  end

  it 'checks for overlap' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)

    board.place(cruiser, %w[A1 A2 A3])
    submarine = Ship.new('Submarine', 2)

    expect(board.valid_placement?(submarine, %w[B1 C1])).to eq(true)
    expect(board.valid_placement?(submarine, %w[A1 B1])).to eq(false)

    expect(board.overlap?(%w[B1 C1])).to eq(false)
    expect(board.overlap?(%w[A1 B1])).to eq(true)
  end

  it 'renders cells by row' do
    board = Board.new
    expect(board.row_render(false, "A")).to eq(". . . .")
    expect(board.row_render(true, "A")).to eq(". . . .")
  end

  it 'can render board' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])
    expect(board.board_render).to eq("  1 2 3 4 \n" +
                              "A . . . . \n" +
                              "B . . . . \n" +
                              "C . . . . \n" +
                              "D . . . . \n")
  end

  it 'can render board(true)' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])

    expect(board.board_render(true)).to eq("  1 2 3 4 \n" +
                                    "A S S S . \n" +
                                    "B . . . . \n" +
                                    "C . . . . \n" +
                                    "D . . . . \n")
  end

  it 'randomly places ships' do
    # blarg test random array sample
    # possible_arrays could look like
    #  [["A1", "A2", "A3"],
    #  ["A2", "A3", "A4"],
    #  ["B1", "B2", "B3"],
    #  ["B2", "B3", "B4"],
    #  ["C1", "C2", "C3"],
    #  ["C2", "C3", "C4"],
    #  ["D1", "D2", "D3"],
    #  ["D2", "D3", "D4"],
    #  ["A1", "B1", "C1"],
    #  ["B1", "C1", "D1"],
    #  ["A2", "B2", "C2"],
    #  ["B2", "C2", "D2"],
    #  ["A3", "B3", "C3"],
    #  ["B3", "C3", "D3"],
    #  ["A4", "B4", "C4"],
    #  ["B4", "C4", "D4"]]
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    board.random_place(cruiser)
    board.random_place(submarine)

    expect(board.cells.values.count { |cell| cell.empty? == false }).to eq(5)
    # board.cells.count do |coord, cell|
    #   # require 'pry'; binding.pry
    #   cell.empty? == false
    # end
  end
end
