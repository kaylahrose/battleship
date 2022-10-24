require './lib/ship'

RSpec.describe Ship do
  # iteration 1
  let(:cruiser) { Ship.new('Cruiser', 3) }
  # before(:each) do
  #   cruiser = Ship.new('Cruiser', 3)
  #   @submarine = Ship.new('Submarine', 2)
  # end

  describe '#initialize' do
    it 'exists' do
      expect(cruiser).to be_an_instance_of(Ship)
    end

    it 'has a name' do
      expect(cruiser.name).to eq('Cruiser')
    end

    it 'has a length' do
      expect(cruiser.length).to eq(3)
    end

    it 'has health' do
      expect(cruiser.health).to eq(3)
    end

    it 'can returns if sunk' do
      expect(cruiser.sunk?).to eq(false)
    end

    context 'hit damage' do
      before(:each) do
        cruiser.hit
      end

      it 'can take damage with hit' do
        # cruiser.hit
        expect(cruiser.health).to eq(2)
      end

      it 'can be sunk' do
        # cruiser.hit
        expect(cruiser.health).to eq(2)
        cruiser.hit
        expect(cruiser.health).to eq(1)
        expect(cruiser.sunk?).to eq(false)
        cruiser.hit
        expect(cruiser.sunk?).to eq(true)
      end
    end

    # it 'can take damage with hit' do
    #   cruiser.hit
    #   expect(cruiser.health).to eq(2)
    # end

    # it 'can be sunk' do
    #   cruiser.hit
    #   expect(cruiser.health).to eq(2)
    #   cruiser.hit
    #   expect(cruiser.health).to eq(1)
    #   expect(cruiser.sunk?).to eq(false)
    #   cruiser.hit
    #   expect(cruiser.sunk?).to eq(true)
    # end
  end
end
