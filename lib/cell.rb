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
    @fired_upon = true
  end

  def cell_render(show = false)
    # blarg, create own scenario
    if empty? == false
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
    elsif @fired_upon
      'M'
    end
  end
end
