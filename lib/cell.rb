class Cell
  attr_reader :coordinate, :damage, :ship

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
    # blarg if time, put guard in gameplay about being able to fire upon cell twice
    ship.hit if empty? == false
      # ship.hit
      # @fired_upon = true
    # else
      # @fired_upon = true
    # end
    @fired_upon = true
  end

  # def ship_present?
  #   !@ship.nil?
  # end

  def cell_render(show = false)
    #blarg, create own scenario
    if empty? == false #if there's a ship on the cell
      if @ship.sunk?
        'X'
      elsif @fired_upon
        'H'
      elsif show
        'S'
      else
        '.'
      end
    elsif @fired_upon == false
      '.'
    elsif @fired_upon #== true # && @ship.nil?
      'M'
    end
  end
  
  # def ship_was_hit(show)
  #   # show && @fired_upon || @fired_upon
  #   @fired_upon || @fired_upon
  # end
end
