require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    boats = Boat.first(5) # returns array
    Boat.where(id: boats.map(&:id))  #convert to activerecord relation
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length >= 20")
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(:captain_id=>nil)
  end

  def self.longest
    Boat.all.order(length: :desc).limit(1)[0]
  end

  def self.sailboats
    # Convoluted - Ask boat classifications for boats with classification sailboat (this will be an array)
    # then convert to ActiveRecord:Relation so test can use pluck
    sailboat = Classification.find_by(:name => "Sailboat")
    boats = BoatClassification.find_boats_by_classification(sailboat.id)
    Boat.where(id: boats.map(&:id))
  end

  def self.with_three_classifications
    # same convoluted logic - having problem figuring out how to get
    # BoatClassification to return boats as activerecord:relation
    boats = BoatClassification.find_boats_by_number_classifications (3)
    Boat.where(id: boats.map(&:id))
  end
end
