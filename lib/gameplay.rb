require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
    attr_reader :menu
    attr_accessor :input
    def initialize
        @menu = "Welcome to BATTLESHIP\n" + 'Enter p to play. Enter q to quit.'
        @input = nil
    end

  def main_menu
    # puts 'Welcome to BATTLESHIP'
    # puts 'Enter p to play. Enter q to quit.'
    puts @menu
    @input = gets.strip
    # # require 'pry'; binding.pry
    if input == 'p'
        setup
    end
    #   board = Board.new
    #   cruiser = Ship.new('Cruiser', 3)
    #   board.place(cruiser, %w[A1 A2 A3])
    #   puts board.board_render
    #   # require 'pry'; binding.pry
    # end
  end

  def setup
    computer_setup
    player_setup
    
  end

  def computer_setup
    # require 'pry'; binding.pry
    comp_board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    comp_board.place(cruiser, %w[A1 A2 A3])
    submarine = Ship.new('Submarine', 2)
    comp_board.place(cruiser, %w[C2 D2])
    comp_board.board_render
# require 'pry'; binding.pry
  
  end

  def player_setup
    player_board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    
    submarine = Ship.new('Submarine', 2)
  instructions = "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    "The Cruiser is three units long and the Submarine is two units long."
    puts instructions
    puts player_board.board_render
   
# require 'pry'; binding.pry
  end


end
