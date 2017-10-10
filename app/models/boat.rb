class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.order('name DESC').limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    sailboat = Classification.where(name: "Sailboat")
    boat = BoatClassification.where(classification_id: sailboat.ids)
    all_ids = []
    boat.to_a.each do |boat|
      all_ids << boat.boat_id
    end
    Boat.where(id: all_ids)

  end

  def self.with_three_classifications
    boat = BoatClassification.having('COUNT(boat_id) > 2').group('boat_id')
    all_ids = []
    boat.to_a.each do |boat|
      all_ids << boat.boat_id
    end
    Boat.where(id: all_ids)
  end

end
