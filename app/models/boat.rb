class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
  find_by_sql("SELECT name FROM boats LIMIT 5")
end

def self.dinghy
  find_by_sql("SELECT name FROM boats WHERE length < 20")
end

def self.ship
  find_by_sql("SELECT name FROM boats WHERE length >= 20")
end

def self.last_three_alphabetically
  find_by_sql("SELECT name FROM boats ORDER BY name DESC LIMIT 3")
end

def self.without_a_captain
  Boat.where(captain_id: nil)
end

def self.longest
  length = Boat.order(length: :desc).limit(1).first.length
  Boat.where('length = ?', length)
end

def self.sailboats
  Boat.joins(:classifications).where(classifications: {name: "Sailboat"})
end

def self.with_three_classifications
  Boat.joins(:classifications).group(:boat_id).having("count(classification_id) = ?", 3)
end
end
