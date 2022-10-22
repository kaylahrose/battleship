require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
    def main_menu
        puts "Welcome to BATTLESHIP"
        puts "Enter p to play. Enter q to quit."
        selection = gets.strip
        # require 'pry'; binding.pry
        if selection == "p"
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        board.place(cruiser, ["A1", "A2", "A3"])
        puts board.board_render
        # require 'pry'; binding.pry
        end
    end

    def setup(selection)
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        board.place(cruiser, ["A1", "A2", "A3"])
        board.board_render
        require 'pry'; binding.pry

        
    end

    
end