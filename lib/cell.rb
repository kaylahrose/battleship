class Cell
    attr_reader :coordinate, :contents
    def initialize(coordinate)
        @coordinate = coordinate
        @contents = nil
       
    end

    def ship
    end

    def empty?
        @contents == nil
    end
end