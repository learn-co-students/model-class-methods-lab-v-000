require 'spec_helper'

describe Boat do
  describe "::first_five" do
    it "returns the first five Boats" do
    end
  end

  describe "#sailboats" do
    it "returns all boats that are sailboats" do
      boat = Boat.find_by(name: "Whatever this is supposed to be")
      expect(Boat.first).to eq(boat)
    end
  end

  describe "#with_three_classifications" do
    it "returns boats with three classifications" do

    end
  end

  describe "#last_three_alphabetically" do
    it "returns last three boats in alphabetical order" do

    end
  end

  describe "#unique_captain_names" do
    it "returns only boats with unique captains" do

    end
  end

  describe "#without_a_captain" do
    it "returns boats without a captain" do

    end
  end
end
