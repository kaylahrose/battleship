require './lib/cell'

class Board
  attr_reader :cells, :letter, :number

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

  # def initialize(width, height)
  #   height = 5
  #   width = 4
  #   numbers = Array.new(width + 1) {|i| i.to_s }
  #   numbers = numbers.shift.join(" ")
  #   last_letter = (("A".ord) + (height - 1)).chr
  #   letters = Range.new("A",last).to_a
  #   array = []
  #   letters.each do |letter|
  #     numbers.each do |number|
  #       array << letter + number
  #     end
  #   end
  #   @cells = {}
  #   @cells.each do |coord|
  #     @cells[coord] = Cell.new(coord)
  #   end
  # end

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
      cells[coordinate].empty? == false
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
    if @letter.uniq.size == 1
      consec_coord_num?
    elsif @number.uniq.size == 1
      consec_coord_letter?
    else
      false
    end
  end

  def separate_coordinates(coordinate_array)
    @letter = []
    @number = []
    coordinate_array.each do |coordinate|
      @letter << coordinate[0]
      @number << coordinate[1]
    end
  end

  def consec_coord_num?
    if @number == @number.sort
      @number[-1].to_i == @number[0].to_i + (@number.length - 1)
    else
      false
    end
  end

  def consec_coord_letter?
    if @letter == @letter.sort
      @letter[-1].ord == @letter[0].ord + (@letter.length - 1)
    else
      false
    end
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    else
      false
    end
  end

  def board_render(show = false)
    "  1 2 3 4 \n" +
      "A #{row_render(show, 'A')} \n" +
      "B #{row_render(show, 'B')} \n" +
      "C #{row_render(show, 'C')} \n" +
      "D #{row_render(show, 'D')} \n"
  end

  def row_render(show, row_letter)
    row = cells.map do |coordinate, cell|
      cell.cell_render(show) if coordinate[0] == row_letter
    end
    row.compact.join(' ')
  end

  def random_place(ship)
    possible_arrays = []
    ('A'..'D').to_a.each do |letter|
      ("#{letter}1".."#{letter}4").each_cons(ship.length) do |a|
        possible_arrays << a
      end
    end
    (1..4).to_a.each do |number|
      ("#{number}A".."#{number}D").each_cons(ship.length) do |a|
        possible_arrays << a.map do |b|
          b.reverse
        end
      end
    end
    until place(ship, possible_arrays.sample)
    end
  end
end

# def initialize
#   @cells = {
#     'A1' => Cell.new('A1'),
#     'A2' => Cell.new('A2'),
#     'A3' => Cell.new('A3'),
#     'A4' => Cell.new('A4'),
#     'B1' => Cell.new('B1'),
#     'B2' => Cell.new('B2'),
#     'B3' => Cell.new('B3'),
#     'B4' => Cell.new('B4'),
#     'C1' => Cell.new('C1'),
#     'C2' => Cell.new('C2'),
#     'C3' => Cell.new('C3'),
#     'C4' => Cell.new('C4'),
#     'D1' => Cell.new('D1'),
#     'D2' => Cell.new('D2'),
#     'D3' => Cell.new('D3'),
#     'D4' => Cell.new('D4')
#   }
# end
# # "A1".succ
# board = ["A1"]
# height = 5
# width = 4

# test = Array.new(width + 1) {|i| i.to_s }
# test.shift
# test
# # returns ["1", "2", "3", .... width]
# test.join(" ")
# 1..10
# ("  #{(1..10.to_a.join(" "))} \n"
# # ^^ for board render instead of ("  1 2 ... 9 10 ")

# height = 5
# # last = nil
# last = (("A".ord) + (height - 1)).chr
# letter = Range.new("A",last).to_a
# # returns ["A","B",... to last letter for height]
# letter.each do |letter|
#   numbers.each do |number|
#     array << letter + number
#   end
# end
# array
# => ["A1",
#  "A2",
#  "A3",
#  "A4",
#  "B1",
#  "B2",
#  "B3",
#  "B4",
#  "C1",
#  "C2",
#  "C3",
#  "C4",
#  "D1",
#  "D2",
#  "D3",
#  "D4",
#  "E1",
#  "E2",
#  "E3",
#  "E4"]
# h = {}
# array.each do |coord|
#   h[coord] = Cell.new(coord)
# end

# # get a range, [a1 ... d4], iterate through

# def initialize(width, height)
#   height = 5
#   width = 4
#   numbers = Array.new(width + 1) {|i| i.to_s }
#   numbers = numbers.shift.join(" ")
#   last_letter = (("A".ord) + (height - 1)).chr
#   letters = Range.new("A",last).to_a
#   array = []
#   letters.each do |letter|
#     numbers.each do |number|
#       array << letter + number
#     end
#   end
#   board = {}
#   board.each do |coord|
#     board[coord] = Cell.new(coord)
#   end
# end

# def board_render
#   p array.chunk_while {|i, j| i[0] == j[0] }.to_a
#   sample = board.values.chunk_while {|i,j| i.coordinate[0] == j.coordinate[0] }.to_a
#   testing = sample.map do |row|
#     row.map do |cell
#       cell.cell_render
#     end.join(" ")
#   end
#   counter = 0
#   puts ("  ") + numbers.join(" ")
#   letts.map do |letter|
#     puts letter + (" ") + testing[counter] + "\n"
#     counter +=1
#   end
# end

# def random_place(ship)
#   possible_arrays = []
#   ('A'..'D').to_a.each do |letter|
#     ("#{letter}1".."#{letter}4").each_cons(ship.length) do |a|
#       possible_arrays << a
#     end
#   end
#   (1..4).to_a.each do |number|
#     ("#{number}A".."#{number}D").each_cons(ship.length) do |a|
#       possible_arrays << a.map do |b|
#         b.reverse
#       end
#     end
#   end
#   until place(ship, possible_arrays.sample)
#   end
# end
