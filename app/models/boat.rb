require 'pry'
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.where("id <= 5")
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

  def self.sailboats
    # Convoluted - Ask boat classifications for boat ids with classification sailboat.
    # then find the corresponding boats (this will be an array)
    # then convert to ActiveRecord:Relation so test can use pluck
    sailboat = Classification.find_by(:name => "Sailboat")
    ids = BoatClassification.find_boats_by_classification(sailboat.id)
    boats = ids.map { |id| Boat.find(id)}
    Boat.where(id: boats.map(&:id))
  end

  def self.with_three_classifications
    # same convoluted logic - having problem figuring out how to get boats from
    # classification data and then convert to activerecord:relation
    list = BoatClassification.find_boats_by_number_classifications (3)
    ids = list.map { | classification | classification.boat_id }
    boats = ids.map { |id| Boat.find(id) }
    Boat.where(id: boats.map(&:id))
  end
end
