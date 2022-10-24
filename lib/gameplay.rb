require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
  attr_accessor :comp_board, :player_board, :comp_cruiser, :comp_submarine,
                :player_cruiser, :player_submarine, :input, :shot

  def initialize
    @comp_board = Board.new
    @player_board = Board.new
    @comp_cruiser = Ship.new('Cruiser', 3)
    @comp_submarine = Ship.new('Submarine', 2)
    @player_cruiser = Ship.new('Cruiser', 3)
    @player_submarine = Ship.new('Submarine', 2)
    @input = nil
    @shot = nil
  end

  def main_menu
    welcome_message
    input = gets.strip
    if input == 'p'
      if comp_board.cells.any? { |coordinate, cell| cell.fired_upon? }
        Gameplay.new.setup
      end

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
  end

  def player_setup
    intstructions
    @input = gets.strip.upcase.split
    validate_cruiser(@input)
    puts "\n"
    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    @input = gets.strip.upcase.split
    validate_sub(@input)
    puts player_board.board_render(true)
    puts "\n" 
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
    until @input.all? { |coordinate| player_board.valid_coordinate?(coordinate) } && player_board.place(player_submarine, @input)
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end
  end

  def turn
    puts '=============COMPUTER BOARD============='
    puts comp_board.board_render(true)
    puts '==============PLAYER BOARD=============='
    puts player_board.board_render(true)
    puts 'Enter the coordinate for your shot:'
    fire
  end

  def fire
    @shot = gets.strip.upcase
    validate_shot(@shot)
  end

  def validate_shot(shot)
    if comp_board.valid_coordinate?(@shot) == false
      puts "invalid, please try again"
      fire
    end 
    fired_upon?(@shot)
  end

  def fired_upon?(shot)
    if comp_board.cells[@shot].fired_upon?
      puts 'This cell has been fired upon, please try again'
      fire
    else
      comp_board.cells[@shot].fire_upon
      computer_shot(@shot)
    end
  end

  def computer_shot(shot)
    comp_shot = player_board.cells.keys.sample
    comp_shot = player_board.cells.keys.sample while player_board.cells[comp_shot].fired_upon?
    player_board.cells[comp_shot].fire_upon

    results(@shot, comp_shot)

  end

  def results(shot, comp_shot)
    puts "Your shot on #{@shot} #{hit_or_miss_comp(@shot)}."
    puts "My shot on #{comp_shot} #{hit_or_miss_player(comp_shot)}."

    if comp_submarine.sunk? && comp_cruiser.sunk?
      sleep(2)
      puts "\n"
      puts "You won!"
      puts "\n"
      sleep(2)
      main_menu
    elsif player_cruiser.sunk? && player_submarine.sunk?
      sleep(2)
      puts "\n"
      puts "I won!"
      puts "\n"
      sleep(2)
      main_menu
    end
    sleep(2)

    turn
  end

  def hit_or_miss_comp(shot)
    # require 'pry'; binding.pry
    if comp_board.cells[@shot].ship_present? && comp_board.cells[@shot].ship.sunk?
      'sunk my ship!'
    elsif comp_board.cells[@shot].ship_present?
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
    puts " \n" +
          "============ Welcome to BATTLESHIP ============\n" + 
          " \n" 
          sleep(2)
    puts 'Enter p to play. Enter q to quit.'
  end

  def intstructions
    puts "\n" 
    puts "I have laid out my ships on the grid.\n"
    puts "\n"
    puts comp_board.board_render
    puts "\n"
    # sleep(2)
    puts "You now need to lay out your two ships.\n"
    # sleep(2)
    puts 'The Cruiser is three units long and the Submarine is two units long.'
    puts "\n"
    # sleep(2)
    puts player_board.board_render
    puts 'Enter the squares for the Cruiser (3 spaces):'
  end


  
end
