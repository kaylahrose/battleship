require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
  attr_reader :menu
  attr_accessor :input, :comp_board, :player_board, :comp_cruiser, :comp_submarine,
                :player_cruiser, :player_submarine

  def initialize
    @menu = "Welcome to BATTLESHIP\n" + 'Enter p to play. Enter q to quit.'
    @input = nil
    @comp_board = Board.new
    @player_board = Board.new
    @comp_cruiser = Ship.new('Cruiser', 3)
    @comp_submarine = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
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
    comp_board.random_place(@comp_cruiser)

    comp_board.random_place(@comp_submarine)
    puts comp_board.board_render(true)
  end

  def player_setup
    instructions = "I have laid out my ships on the grid.\n" +
                   "You now need to lay out your two ships.\n" +
                   'The Cruiser is three units long and the Submarine is two units long.'
    puts instructions
    puts player_board.board_render
    puts 'Enter the squares for the Cruiser (3 spaces):'
    test = gets.strip.upcase.split
    # require 'pry'; binding.pry
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate) }
      puts 'invalid, please try again'
      test = gets.strip.upcase.split
      # require 'pry'; binding.pry
    end
    # until player_board.valid_coordinate?(test)
    #     puts "invalid, please try again"
    #     test = gets.strip.upcase.split
    # end
    until player_board.place(player_cruiser, test)
      puts 'invalid, please try again'
      test = gets.strip.upcase.split
    end

    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    test = gets.strip.upcase.split
    until test.all? { |coordinate| player_board.valid_coordinate?(coordinate) }
      puts 'invalid, please try again'
      test = gets.strip.upcase.split
    end
    until player_board.place(player_submarine, test)
      puts 'invalid, please try again'
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
    while comp_board.cells[shot].fired_upon?
      puts 'This cell has been fired upon, please try again'
      # test = gets.strip.upcase.split
      shot = gets.strip.upcase
    end
    comp_board.cells[shot].fire_upon
    # require 'pry'; binding.pry
    comp_shot = player_board.cells.keys.sample
    comp_shot = player_board.cells.keys.sample while player_board.cells[comp_shot].fired_upon?
    player_board.cells[comp_shot].fire_upon

    results(shot, comp_shot)
  end

  def results(shot, comp_shot)
    puts "Your shot on #{shot} was a #{hit_or_miss_comp(shot)}."
    puts "My shot on #{comp_shot} was a #{hit_or_miss_player(comp_shot)}."

    # occupied_cells = comp_board.cells.select do |coordinate, cell|
    #   require 'pry'
    #   binding.pry
    # end
    if comp_submarine.sunk? && comp_cruiser.sunk?
      puts "You won!"
      abort
    elsif player_cruiser.sunk? && player_submarine.sunk?
      puts "I won!"
      abort
    end

    turn
  end

  def hit_or_miss_comp(shot)
    # require 'pry'; binding.pry
    if comp_board.cells[shot].fired_upon? && comp_board.cells[shot].ship_present?
      'hit'
    else
      'miss'
    end
  end

  def hit_or_miss_player(comp_shot)
    if player_board.cells[comp_shot].fired_upon? && player_board.cells[comp_shot].ship_present?
      'hit'
    else
      'miss'
    end
  end
  
  def endgame
  end

end
