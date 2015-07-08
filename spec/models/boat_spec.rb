require 'spec_helper'

describe Boat do
  describe "::first_five" do
    it "returns the first five Boats" do
      boats = ["H 28", "Nacra 17", "Regulator 34SS", "Zodiac CZ7", "Boston Whaler"]
      expect(Boat.first_five.pluck(:name)).to eq(boats)
    end
  end

  describe "::dinghy" do
    it "returns boats shorter than 20 feet" do
      boats = ["Nacra 17", "Boston Whaler", "49er", "Laser", "Harpoon 4.7", "Sunfish"]
      expect(Boat.dinghy.pluck(:name)).to eq(boats)
    end
  end

  describe "::ship" do
    it "returns boats 20 feet or longer" do
      boats = ["H 28", "Regulator 34SS", "Zodiac CZ7", "Cape Dory", "Triton 21 TRX", "Sun Tracker Regency 254 XP3"]
      expect(Boat.ship.pluck(:name)).to eq(boats)
    end
  end

  describe "::last_three_alphabetically" do
    it "returns last three boats in alphabetical order" do
      boats = ["Zodiac CZ7", "Triton 21 TRX", "Sunfish"]
      expect(Boat.last_three_alphabetically.pluck(:name)).to eq(boats)
    end
  end

  describe "::without_a_captain" do
    it "returns boats without a captain" do
      boats = ["Harpoon 4.7", "Sunfish"]
      expect(Boat.without_a_captain.pluck(:name)).to eq(boats)
    end
  end

  describe "::sailboats" do
    it "returns all boats that are sailboats" do
      boats = ["H 28", "Nacra 17", "49er", "Laser", "Harpoon 4.7", "Sunfish"]
      expect(Boat.sailboats.pluck(:name)).to eq(boats)
    end
  end

  describe "::with_three_classifications" do
    it "returns boats with three classifications" do
      boats = ["Nacra 17", "Zodiac CZ7", "Sun Tracker Regency 254 XP3"].sort
      expect(Boat.with_three_classifications.pluck(:name).sort).to eq(boats)
    end
  end

end
