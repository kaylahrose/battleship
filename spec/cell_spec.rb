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

        it 'returns if fired at' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            expect(cell.fired_upon?).to eq(false)

            cell.fire_upon
            expect(cell.fired_upon?).to eq(true)
        end

        it 'reduces ships health when fired at' do
            cell = Cell.new("B4")
            cruiser = Ship.new("Cruiser", 3)
            cell.place_ship(cruiser)
            cell.fire_upon
            expect(cell.ship.health).to eq(2)
        end

        it 'renders new cell' do
            cell_1 = Cell.new("B4")
            expect(cell_1.render).to eq(".")
        end

        it 'renders empty fired at cell' do
            cell_1 = Cell.new("B4")
            cell_1.fire_upon
            expect(cell_1.render).to eq("M")
        end
        
        it 'renders new cell with ship' do
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)
            cell_2.place_ship(cruiser)
            expect(cell_2.render).to eq(".")
        end

        it 'renders cell with undamaged ship' do
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)
            cell_2.place_ship(cruiser)
            expect(cell_2.render(true)).to eq("S")
        end

        it 'renders fired upon cell with damaged ship' do
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)
            cell_2.place_ship(cruiser)
            cell_2.fire_upon
            expect(cell_2.render).to eq("H")
        end

        it 'renders cell with sunk ship' do
            cell_2 = Cell.new("C3")
            cruiser = Ship.new("Cruiser", 3)
            cell_2.place_ship(cruiser)
            cell_2.fire_upon
            expect(cruiser.sunk?).to eq(false)

            cruiser.hit
            cruiser.hit
            expect(cruiser.sunk?).to eq(true)

            expect(cell_2.render).to eq("X")
        end
    end
end
