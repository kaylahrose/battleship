require './lib/cell'
class Board
  attr_accessor :cells

  def initialize
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
      key_coordinate == coordinate
    end
  end

  def valid_placement?(ship, coordinate_array)
    if overlap?(coordinate_array) == false
      valid_placement_array_length?(ship, coordinate_array)
    else
      false
    end
  end

  def overlap?(coordinate_array)
    coordinate_array.any? do |coordinate|
      cells[coordinate].ship_present?
    end
  end


  def valid_placement_array_length?(ship, coordinate_array)
    if coordinate_array.length == ship.length
      consecutive_coordinates?(coordinate_array)
    else
      false
    end
  end

  def consecutive_coordinates?(coordinate_array)
    separate_coordinates(coordinate_array)
    if @@letter.uniq.size <= 1
      consec_coord_num?
    elsif @@number.uniq.size <= 1
      consec_coord_letter?
    else
      false
    end
  end

  def separate_coordinates(coordinate_array)
    @@letter = []
    @@number = []
    coordinate_array.each do |coordinate|
      @@letter << coordinate[0]
      @@number << coordinate[1]
    end
  end

  def consec_coord_num?
    if @@number == @@number.sort
      @@number[-1].to_i == @@number[0].to_i + (@@number.length - 1)
    else
      false
    end
  end

  def consec_coord_letter?
    if @@letter == @@letter.sort
      @@letter[-1].ord == @@letter[0].ord + (@@letter.length - 1)
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
  end

  def board_render(show = false)
    return ("  1 2 3 4 \n" +
        "A #{cells.map do |coordinate, cell|
        cell.cell_render  if coordinate[0] == "A"
        end}   \n" +
        "B . . . . \n" +
        "C . . . . \n" +
        "D . . . . \n")
  end
  # #{cells["A1"].cell_render}
end
