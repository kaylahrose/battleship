require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/gameplay'

RSpec.describe Gameplay do
    it 'prints main menu' do
        

    end

    # it plays
    # it quits
    # it 'place the computer’s ships and the players ships to set up the game'
    it 'has computer board' do
    end
    it 'has player board' do 
    end
    it 'computer player places ships randomly' do
    end
    
    it 'prints placement instructions' do
        # instructions variable, coppy paste from interaction [pattern to assertion
    
    end
    it 'places players ship on the board' do
        # might've been handled in baordspec
    end

    it 'shows the new board with ship to user' do
        # might've been handled in board spec
    end

    it 'asks user to place another ship' do
        # not sure
    end
    it 'handles invalid sequences' do
        # i can do this
    end
    # User is shown the main menu where they can play or quit
    # Setup:
    
    # Computer can place ships randomly in valid locations
    # User can enter valid sequences to place both ships
    # Entering invalid ship placements prompts user to enter valid placements

#     User board is displayed showing hits, misses, sunken ships, and ships
# Computer board is displayed showing hits, misses, and sunken ships
# Computer chooses a random shot
# Computer does not fire on the same spot twice
# User can choose a valid coordinate to fire on
# Entering invalid coordinate prompts user to enter valid coordinate
# Both computer and player shots are reported as a hit, sink, or miss
# User is informed when they have already fired on a coordinate
# Board is updated after a turn

# Game ends when all the user’s ships are sunk
# Game ends when all the computer’s ships are sunk
# Game reports who won
# Game returns user back to the Main Menu


end