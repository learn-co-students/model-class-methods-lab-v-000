  require 'spec_helper'

describe Captain do
  describe "::catamaran_operators" do
    it "returns all captains of catamarans" do
      captains = ["Captain Kidd", "Samuel Axe"]
      expect(Captain.catamaran_operators.pluck(:name)).to eq(captains)
    end
  end

  describe "::sailors" do
    it "returns captains with sailboats" do
      captains = ["Captain Cook", "Captain Kidd", "Samuel Axe"]
      expect(Captain.sailors.pluck(:name)).to eq(captains)
    end
  end

  describe "::talented_seafarers" do
    it "returns captains of motorboats and sailboats" do
      captains = ["Captain Cook", "Samuel Axe"]
      expect(Captain.talented_seafarers.pluck(:name)).to eq(captains)
    end
  end

  describe "::non_sailors" do
    it "returns people who are not captains of sailboats" do
      captains = ["William Kyd", "Arel English", "Henry Hudson"]
      expect(Captain.non_sailors.pluck(:name)).to eq(captains)
    end
  end

  #new tests

  # describe "::struggling_captains" do
  #   it "returns all captains who have two boats or fewer" do
  #     captains = ["Captain Kidd", "William Kyd", "Arel English", "Henry Hudson", "Samuel Axe"] 
  #     expect(Captain.struggling_captains.pluck(:name)).to eq(captains)
  #   end
  # end

  # describe "::long_boats" do
  #   it "returns the captains whose boat length sum exceeds 40" do
  #     captains = ["Captain Cook", "Arel English", "Samuel Axe"]
  #     expect(Captain.long_boats.pluck(:name)).to eq(captains)
  #   end
  # end
end
