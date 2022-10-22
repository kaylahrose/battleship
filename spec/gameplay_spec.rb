require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/gameplay'

RSpec.describe Gameplay do
  it 'prints main menu' do
    gameplay = Gameplay.new
    # require 'pry'; binding.pry
    expect(gameplay.menu).to eq("Welcome to BATTLESHIP\nEnter p to play. Enter q to quit.")
  end

  it 'plays' do
    gameplay = Gameplay.new
    gameplay.input = "p"
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
        # require 'pry'; binding.pry
        # make it equal to 'p' in test setup

    expect(board).to be_an_instance_of(Board)
    expect(cruiser).to be_an_instance_of(Ship)
  end

  xit 'quits' do
  end

  # Setup:

  xit 'has computer board' do
  end

  xit 'has player board' do
  end

  xit 'computer player places ships randomly' do
  end

  xit 'prints placement instructions' do
    # instructions variable, coppy paste from interaction [pattern to assertion
  end

  xit 'places players ship on the board' do
    # might've been handled in baordspec
  end

  xit 'shows the new board with ship to user' do
    # might've been handled in board spec
  end

  xit 'asks user to place another ship' do
    # not sure
  end
  xit 'handles invalid sequences' do
    # i can do this
  end

  # Turn:

  xit 'User board is displayed showing hits, misses, sunken ships, and ships' do
  end

  xit 'Computer board is displayed showing hits, misses, and sunken ships' do
  end

  xit 'Computer chooses a random shot' do
  end

  xit 'Computer does not fire on the same spot twice' do
  end

  xit 'User can choose a valid coordinate to fire on' do
  end

  xit 'Entering invalid coordinate prompts user to enter valid coordinate' do
  end

  xit 'Both computer and player shots are reported as a hit, sink, or miss' do
  end

  xit 'User is informed when they have already fired on a coordinate' do
  end

  xit 'Board is updated after a turn' do
  end

  xit 'Game ends when all the users ships are sunk' do
  end

  xit 'Game ends when all the computers ships are sunk' do
  end

  xit 'Game reports who won' do
  end

  xit 'Game returns user back to the Main Menu' do
  end
end
