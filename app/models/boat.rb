class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boats = Boat.limit(5)
  end

  def self.dinghy
    boats = Boat.where("length < ?", 20)
  end

  def self.ship
    boats = Boat.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    boats = Boat.order('name desc').limit(3)
  end

  def self.without_a_captain
    boats = Boat.where('captain_id' => nil)
  end

  def self.sailboats
    boats = Boat.joins(boat_classifications: :classification).where('classifications.name' => "Sailboat")
  end

  def self.with_three_classifications
    #boats = Boat.joins(boat_classifications: :classification).where('classifications.name').count
    results = []
    boats = Boat.joins(boat_classifications: :classification)
    boats.each do |boat|
      if boat.classifications.count == 3
        results << boat 
      end 
    end 
    Boat.where('id' => results)
  end
end
