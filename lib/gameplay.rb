require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
  attr_accessor :comp_board, :player_board, :comp_cruiser, :comp_submarine,
                :player_cruiser, :player_submarine, :input

  def initialize
    @comp_board = Board.new
    @player_board = Board.new
    @comp_cruiser = Ship.new('Cruiser', 3)
    @comp_submarine = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
    @input = nil
  end

  def main_menu
    welcome_message
    # puts "Welcome to BATTLESHIP\n" + 
    #       'Enter p to play. Enter q to quit.'
  input = gets.strip
    if input == 'p'
      setup
    else
      abort
    end
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
    intstructions
    @input = gets.strip.upcase.split
    validate_cruiser(@input)
    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    @input = gets.strip.upcase.split
    validate_sub(@input)
    puts player_board.board_render(true)
    turn
  end

  def validate_cruiser(input)
    until @input.all? { |coordinate| player_board.valid_coordinate?(coordinate) }
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end

    until player_board.place(player_cruiser, @input)
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end
  end

  def validate_sub(input)
    until @input.all? { |coordinate| player_board.valid_coordinate?(coordinate) }
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end

    until player_board.place(player_submarine, @input)
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end
  end

  def turn
    puts '=============COMPUTER BOARD============='
    puts comp_board.board_render
    puts '==============PLAYER BOARD=============='
    puts player_board.board_render(true)
    puts 'Enter the coordinate for your shot:'
    shot = gets.strip.upcase
    validate_shot(shot)
  end

  def validate_shot(shot)
    while comp_board.cells[shot].fired_upon?
      puts 'This cell has been fired upon, please try again'
      shot = gets.strip.upcase
    end
    comp_board.cells[shot].fire_upon

  end

  def computer_shot(shot)
    comp_shot = player_board.cells.keys.sample
    comp_shot = player_board.cells.keys.sample while player_board.cells[comp_shot].fired_upon?
    player_board.cells[comp_shot].fire_upon

    results(shot, comp_shot)

  end

  def results(shot, comp_shot)
    puts "Your shot on #{shot} #{hit_or_miss_comp(shot)}."
    puts "My shot on #{comp_shot} #{hit_or_miss_player(comp_shot)}."

    if comp_submarine.sunk? && comp_cruiser.sunk?
      puts "You won!"
      main_menu
    elsif player_cruiser.sunk? && player_submarine.sunk?
      puts "I won!"
      main_menu
    end

    turn
  end

  def hit_or_miss_comp(shot)
    # require 'pry'; binding.pry
    if comp_board.cells[shot].ship_present? && comp_board.cells[shot].ship.sunk?
      'sunk my ship!'
    elsif comp_board.cells[shot].ship_present?
      'was a hit'
    else
      'was a miss'
    end
  end

  def hit_or_miss_player(comp_shot)
    if player_board.cells[comp_shot].ship_present? && player_board.cells[comp_shot].ship.sunk?
      'sunk your ship!'
    elsif player_board.cells[comp_shot].ship_present?
      'was a hit'
    else
      'was a miss'
    end
  end

  # text helper methods

  def welcome_message
    puts "Welcome to BATTLESHIP\n" + 
          'Enter p to play. Enter q to quit.'
  end

  def intstructions
    puts "I have laid out my ships on the grid.\n" +
    "You now need to lay out your two ships.\n" +
    'The Cruiser is three units long and the Submarine is two units long.'
    puts player_board.board_render
    puts 'Enter the squares for the Cruiser (3 spaces):'
  end


  
end
