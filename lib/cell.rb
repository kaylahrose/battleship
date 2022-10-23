class Cell
  attr_reader :coordinate, :damage
  attr_accessor :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_obj)
    @ship = ship_obj
  end

  def fired_upon?
    @fired_upon == true
  end

  def fire_upon
    if ship_present? == true
      ship.health -= 1
      @fired_upon = true
    else
      @fired_upon = true
      # require 'pry'; binding.pry
    end
  end

  def ship_present?
    !@ship.nil?
    # require 'pry'; binding.pry
  end
  # returns a String representation of the Cell for when we need to print the board
  #  A cell can potentially be rendered as:

  # ”.” if the cell has not been fired upon.
  # “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
  # “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
  # “X” if the cell has been fired upon and its ship has been sunk.
  def cell_render(show = false)
    # if ship == empty?
    #   cell_render_no_ship(show)
    # else
    #   cell_render_with_ship(show)
    # end





    
    if ship_present?
      if @ship.sunk?
        'X'
      elsif ship_was_hit(show)
        'H'
      elsif show
        'S'
      else
        '.'
      end
    elsif @fired_upon == false
      '.'
    elsif @fired_upon == true && @ship.nil?
      'M'
    end
  end
  
  # def cell_render_no_ship
  #   if fired_upon == true
  #     "M"
  #   else
  #     "."
  #   end
  # end

  # def cell_render_with_ship(show)
  #   if ship.sunk?
  #     "X"
  #   elsif fired_upon == true
  #     "H"
  #   elsif show
  #     "S"
  #   else
  #     "."
  #   end
  #   # "S"
  #   #"."
  # end

  def ship_was_hit(show)
    show && @fired_upon || @fired_upon
  end
end
