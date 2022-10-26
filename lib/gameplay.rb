require './lib/board'
require './lib/ship'
require './lib/cell'
class Gameplay
  attr_reader :comp_board, :player_board, :comp_cruiser, :comp_submarine,
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
    input = gets.strip.downcase
    if input == 'p'
      Gameplay.new.setup if comp_board.cells.any? { |_coordinate, cell| cell.fired_upon? }
      setup
      play
    elsif input == 'q'
      abort
    else
      puts 'please only enter: p or q'
      main_menu
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
    instructions
    @input = gets.strip.upcase.split
    validate_cruiser(@input)
    puts "\n"
    puts player_board.board_render(true)
    puts 'Enter the squares for the Submarine (2 spaces):'
    @input = gets.strip.upcase.split
    validate_sub(@input)
    puts player_board.board_render(true)
    puts "\n"
  end

  def validate_cruiser(_input)
    until @input.all? { |coordinate| player_board.valid_coordinate?(coordinate) }
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end

    until player_board.place(player_cruiser, @input)
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end
  end

  def validate_sub(_input)
    until @input.all? { |coordinate| player_board.valid_coordinate?(coordinate) } && player_board.place(player_submarine, @input)
      puts 'invalid, please try again'
      @input = gets.strip.upcase.split
    end
  end

  def play
    until comp_win? || player_win?
      turn
      computer_shot
      results_turn(@shot, @comp_shot)
    end
    results_game
  end

  def turn
    puts '=============COMPUTER BOARD============='
    puts comp_board.board_render
    puts '==============PLAYER BOARD=============='
    puts player_board.board_render(true)
    puts 'Enter the coordinate for your shot:'
    fire
  end

  def fire
    fire_input
    validate_shot
    comp_board.cells[shot].fire_upon
  end

  def validate_shot
    validate_coordinate
    validate_fired_upon
  end

  def validate_coordinate
    # refactor opportunity error message
    until comp_board.valid_coordinate?(@shot)
      puts 'invalid, please try again'
      fire_input
    end
  end

  def fire_input
    @shot = gets.strip.upcase
  end

  def validate_fired_upon
    while comp_board.cells[@shot].fired_upon?
      puts 'This cell has been fired upon, please try again'
      fire_input
      validate_shot
    end
  end

  def computer_shot
    @comp_shot = player_board.cells.keys.sample
    @comp_shot = player_board.cells.keys.sample while player_board.cells[@comp_shot].fired_upon?
    player_board.cells[@comp_shot].fire_upon
  end

  def results_turn(shot, comp_shot)
    puts "Your shot on #{shot} #{hit_or_miss_comp(shot)}."
    puts "My shot on #{comp_shot} #{hit_or_miss_player(comp_shot)}."
    sleep(2)
  end

  def results_game
    if player_win?
      you_won_message
      main_menu
    elsif comp_win?
      i_won_message
      main_menu
    end
  end

  def comp_win?
    player_cruiser.sunk? && player_submarine.sunk?
  end

  def player_win?
    comp_submarine.sunk? && comp_cruiser.sunk?
  end

  def hit_or_miss_comp(_shot)
    if !comp_board.cells[@shot].empty? && comp_board.cells[@shot].ship.sunk?
      'sunk my ship!'
    elsif !comp_board.cells[@shot].empty?
      'was a hit'
    else
      'was a miss'
    end
  end

  def hit_or_miss_player(comp_shot)
    if !player_board.cells[comp_shot].empty? && player_board.cells[comp_shot].ship.sunk?
      'sunk your ship!'
    elsif !player_board.cells[comp_shot].empty?
      'was a hit'
    else
      'was a miss'
    end
  end

  # text helper methods

  def welcome_message
    puts "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "======================== Welcome to BATTLESHIP ========================\n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         " \n"
    puts 'Enter p to play. Enter q to quit.'
  end

  def instructions
    puts "\n"
    puts "I have laid out my ships on the grid.\n"
    puts "\n"
    puts comp_board.board_render
    puts "\n"
    puts "You now need to lay out your two ships.\n"
    puts 'The Cruiser is three units long and the Submarine is two units long.'
    puts "\n"
    puts player_board.board_render
    puts 'Enter the squares for the Cruiser (3 spaces):'
  end

  def you_won_message
    sleep(2)
    puts "\n"
    puts "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "============================== You Won! ===============================\n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         " \n"
    puts "\n"
    sleep(2)
  end

  def i_won_message
    puts "\n"
    puts "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "=============================== I Won! ================================\n" +
         "                                                                       \n" +
         "                                                                       \n" +
         "                                                                       \n" +
         " \n"
    sleep(2)
  end
end
