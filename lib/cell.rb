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

    def render
        # returns a String representation of the Cell for when we need to print the board
        #  A cell can potentially be rendered as:
        
        # ”.” if the cell has not been fired upon.
        # “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
        # “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
        # “X” if the cell has been fired upon and its ship has been sunk.
    end
end