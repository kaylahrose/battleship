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
    test = gets.strip.upcase.split
    # require 'pry'; binding.pry
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate)}
        puts "invalid, please try again"
        test = gets.strip.upcase.split
        # require 'pry'; binding.pry
    end
    # until player_board.valid_coordinate?(test)
    #     puts "invalid, please try again"
    #     test = gets.strip.upcase.split
    # end
    until player_board.place(cruiser, test)
        puts "invalid, please try again"
        test = gets.strip.upcase.split
    end

    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    test = gets.strip.upcase.split
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate)}
        puts "invalid, please try again"
        test = gets.strip.upcase.split
    end
    until player_board.place(submarine, test)
        puts "invalid, please try again"
        test = gets.strip.upcase.split
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
    shot = gets.strip.upcase
    # main_menu if turn == "q"
    # sleep(1)
    comp_board.cells[shot].fire_upon
    # require 'pry'; binding.pry
    comp_shot = player_board.cells.keys.sample
    player_board.cells[comp_shot].fire_upon
    
    results(shot, comp_shot)
  end

  def results(shot, comp_shot)
    puts "Your shot on #{shot} was a #{hit_or_miss_comp(shot)}."
    puts "My shot on #{comp_shot} was a #{hit_or_miss_player(comp_shot)}."
    turn
  end

  def hit_or_miss_comp(shot)
    # require 'pry'; binding.pry
    if comp_board.cells[shot].fired_upon? && comp_board.cells[shot].ship_present?
      "hit"
    else
      "miss"
    end
  end

  def hit_or_miss_player(comp_shot)
    if player_board.cells[comp_shot].fired_upon? && player_board.cells[comp_shot].ship_present?
      "hit"
    else
      "miss"
    end
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
#             test = gets.strip.upcase.split
#         end
#     end
# end