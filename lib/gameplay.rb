require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
  attr_reader :menu
  attr_accessor :input, :comp_board, :player_board

  def initialize
    @menu = "Welcome to BATTLESHIP\n" + 'Enter p to play. Enter q to quit.'
    @input = nil
    @comp_board = Board.new
    @player_board = Board.new
  end

  def main_menu
    puts @menu
    @input = gets.strip
    setup if input == 'p'
  end

  def setup
    computer_setup
    player_setup
  end

  def computer_setup
    cruiser = Ship.new('Cruiser', 3)
    comp_board.random_place(cruiser)
    submarine = Ship.new('Submarine', 2)
    comp_board.random_place(submarine)
    puts comp_board.board_render(true)
  end



  def player_setup
    cruiser = Ship.new('Cruiser', 3)
    submarine = Ship.new('Submarine', 2)
    instructions = "I have laid out my ships on the grid.\n" +
                   "You now need to lay out your two ships.\n" +
                   'The Cruiser is three units long and the Submarine is two units long.'
    puts instructions
    puts player_board.board_render
    puts 'Enter the squares for the Cruiser (3 spaces):'
    test = gets.strip.split
    # require 'pry'; binding.pry
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate)}
        puts "invalid, please try again"
        test = gets.strip.split
        # require 'pry'; binding.pry
    end
    # until player_board.valid_coordinate?(test)
    #     puts "invalid, please try again"
    #     test = gets.strip.split
    # end
    until player_board.place(cruiser, test)
        puts "invalid, please try again"
        test = gets.strip.split
    end

    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    test = gets.strip.split
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate)}
        puts "invalid, please try again"
        test = gets.strip.split
    end
    until player_board.place(submarine, test)
        puts "invalid, please try again"
        test = gets.strip.split
    end
    puts player_board.board_render(true)
    turn
  end

  def turn
    puts '=============COMPUTER BOARD============='
    puts comp_board.board_render
    puts '==============PLAYER BOARD=============='
    puts player_board.board_render(true)
    puts 'Enter the coordinate for your shot:'
    turn = gets.strip
    main_menu if turn == "q"
    sleep(1)
    comp_board.cells[turn].fire_upon
    # require 'pry'; binding.pry
    results
  end

  def results
    puts "Your shot on A4 was a miss.
    My shot on C1 was a miss."
    turn
  end
end


# def render(show = false)
#     if cell.empty?
#         if cell.fired_upon
#             "M"
#         end
#         "."
#     else
#         if cell.fired_upon
#             if ship.health == 0
#                 "X"
#             end
#             "H"
#         end
#     end

#     def valid?
#         until test.all? { |coordinate| player_board.valid_coordinate?(coordinate)}
#             puts "invalid, please try again"
#             test = gets.strip.split
#         end
#     end
# end