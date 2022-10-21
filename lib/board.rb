require './lib/cell'
class Board
  attr_accessor :cells

  def initialize
    # require 'pry'; binding.pry
    @cells = {
      'A1' => Cell.new('A1'),
      'A2' => Cell.new('A2'),
      'A3' => Cell.new('A3'),
      'A4' => Cell.new('A4'),
      'B1' => Cell.new('B1'),
      'B2' => Cell.new('B2'),
      'B3' => Cell.new('B3'),
      'B4' => Cell.new('B4'),
      'C1' => Cell.new('C1'),
      'C2' => Cell.new('C2'),
      'C3' => Cell.new('C3'),
      'C4' => Cell.new('C4'),
      'D1' => Cell.new('D1'),
      'D2' => Cell.new('D2'),
      'D3' => Cell.new('D3'),
      'D4' => Cell.new('D4')
    }
  end

  def valid_coordinate?(coordinate)
    cells.keys.any? do |key_coordinate|
      # require 'pry'; binding.pry
      key_coordinate == coordinate
    end
    # require 'pry'; binding.pry
  end

  def check_overlap
    # check if any of the cell
    if cell.ship == ship
      true
    else
      # call invalid method
      false
    end
      # ?check if any of the coordinates/cells have coordinates already

  end

  def valid_placement?(ship, coordinate_array)
    # if check_overlap == true
    # access ship == nil
    # call ship inside cell, then


    require 'pry'; binding.pry
    # have a conditional statement
    # check if the coordinate are full before correct length verification
    if coordinate_array.length == ship.length
      # iterate through coordinates and shovel letter into one array and numbers into number array

      letter = []
      number = []
      coordinate_array.each do |coordinate|
        letter << coordinate[0]
        number << coordinate[1]
      end
      # if the letters in the array are all the same
      # require 'pry'; binding.pry
      # letter.sort!
      # number.sort!

      if letter.uniq.size <= 1
        # check if the numbers count in order
        if number == number.sort
          number[-1].to_i == number[0].to_i + (number.length - 1)
        else
          false
        end
      # if the numbers in the array are all the same
      elsif number.uniq.size <= 1
        # check if the letters go in order
        # require 'pry'; binding.pry
        if letter == letter.sort
          letter[-1].ord == letter[0].ord + (letter.length - 1)
        else
          false
        end
      else
        false
      end
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        cells[coordinate].ship = ship
      end
    else
      false
      # puts "Invalid placement, please try again"
    end
    # require 'pry'; binding.pry
  end
end
