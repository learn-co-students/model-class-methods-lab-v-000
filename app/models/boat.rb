class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3).order(name: :asc)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    where(id: BoatClassification.sailboat)
  end

  def self.with_three_classifications
      where(id: BoatClassification.boat_classification_count)
  end

  def self.catamaran_boats
    where(id: BoatClassification.catamaran)
  end

  #def self.sailboats_boats
    #where(id: BoatClassification.sailboat)
  #end

  def self.motorboat_boats
    where(id: BoatClassification.motorboat)
  end

end
