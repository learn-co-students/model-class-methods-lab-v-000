class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(captain: nil)
  end

  def self.sailboats

  end

end


# describe "::sailboats" do
#   it "returns all boats that are sailboats" do
#     boats = ["H 28", "Nacra 17", "49er", "Laser", "Harpoon 4.7", "Sunfish"]
#     expect(Boat.sailboats.pluck(:name)).to eq(boats)
#   end
# end
#
# describe "::with_three_classifications" do
#   it "returns boats with three classifications" do
#     boats = ["Nacra 17", "Zodiac CZ7", "Sun Tracker Regency 254 XP3"].sort
#     expect(Boat.with_three_classifications.pluck(:name).sort).to eq(boats)
#   end
# end
