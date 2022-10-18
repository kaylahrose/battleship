require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
    # iteration 1
    # before(:each) do 
    #     cell = Cell.new("B4")
    # end

    describe '#initialize' do
        it 'exists' do
            cell = Cell.new("B4")
            # require 'pry'; binding.pry
            expect(cell).to be_an_instance_of(Cell)
        end

        it 'has a coordinate' do
            cell = Cell.new("B4")
            expect(cell.coordinate).to eq("B4")
        end
            
        it 'has no ship' do
            cell = Cell.new("B4")
            expect(cell.ship).to eq(nil)
        end

        it 'is empty by default' do
            cell = Cell.new("B4")
            expect(cell.empty?).to eq(true)
        end

        it 'is an instance of the Ship class' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser).to be_an_instance_of(Ship)
        end

        it 'places ship' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            cell.ship
            expect(cell.ship).to be_an_instance_of(Ship)
        end

        it 'returns if empty' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            cell.ship
            expect(cell.empty?).to eq(false)
        end 
    end
end
