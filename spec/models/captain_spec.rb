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

  describe "::talented_seamen" do
    it "returns captains of motorboats and sailboats" do
      captains = ["Captain Cook", "Samuel Axe"]
      expect(Captain.talented_seamen.pluck(:name)).to eq(captains)
    end
  end

  describe "::non_sailors" do
    it "returns people who are not captains of sailboats" do
      captains = ["William Kyd", "Arel English", "Henry Hudson"]
      expect(Captain.non_sailors.pluck(:name)).to eq(captains)
    end
  end
end
