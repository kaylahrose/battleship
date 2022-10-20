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

  def valid_placement?(ship, coordinate_array)
    # require 'pry'; binding.pry
    if coordinate_array.length == ship.length 
        # require 'pry'; binding.pry
        letter = []
        number = []
        coordinate_array.each do |coordinate|
            letter << coordinate[0]
            number << coordinate[1]
        end
        # require 'pry'; binding.pry
        if letter.uniq.size <= 1
            number[-1].to_i == number[0].to_i + (number.length - 1)
        elsif number.uniq.size <= 1
            letter[-1].to_i == letter[0].to_i + (letter.length - 1)
        else
            false
        end
    else
        false
    end



  end
end
