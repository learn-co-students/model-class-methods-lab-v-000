class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications


def self.first_five
  #{}"returns the first five Boats"
  all.limit(5)
end

def self.dinghy
  #it "returns boats shorter than 20 feet"
  where("length < 20")
end

def self.ship
  #returns boats 20 feet or longer"
  where("length >= 20")
end

def self.last_three_alphabetically
  #{}it "returns last three boats in alphabetical order
  all.order(name: :desc).limit(3)
end

def self.without_a_captain
  #it "returns boats without a captain
  where(captain_id: nil)
end

def self.sailboats
  #returns all boats that are sailboats
  includes(:classifications).where(classifications: { name: 'Sailboat' })
end


def self.with_three_classifications
  #returns boats with three classifications
  joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
end

def self.longest   #returns the longest boat
  Boat.order(length: :desc).first
end

end
