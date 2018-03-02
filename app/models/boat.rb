class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

#returns the first five Boats
  def self.first_five
    Boat.limit(5)
    #Boat.take(5) users.take(5) # => SELECT * FROM Boat LIMIT 5
  end

#returns boats shorter than 20 feet
  def self.dinghy
    Boat.where("length < ?", 20)
  end

#returns boats 20 feet or longer
  def self.ship
    Boat.where("length > ?", 20)
  end

#returns last three boats in alphabetical order
  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

#returns boats without a captain
  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

#returns all boats that are sailboats
  def self.sailboats
    Boat.includes(:classifications).where(classifications: {name: "Sailboat"})
  end

#returns boats with three classifications
  def self.with_three_classifications
    Boat.joins(:classifications).group("boats.id").having("COUNT(*)=3")
  end
end