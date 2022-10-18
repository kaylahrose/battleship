class Cell
    attr_reader :coordinate, :ship, :damage
    def initialize(coordinate)
        @coordinate = coordinate
        @ship = nil
        @fired_upon = false
       
    end

    # def ship
    # end

    def empty?
        @ship == nil
    end

    def place_ship(ship_obj)
        @ship = ship_obj
    end

    def fired_upon?
        @fired_upon == true
    end

    def fire_upon
        @fired_upon = true
        # require 'pry'; binding.pry
        ship.health -= 1
    end
end