require "pry"

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    order("id LIMIT 5")
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order("name DESC LIMIT 3")
  end

  def self.without_a_captain
    where("captain_id IS NULL")
  end

  def self.sailboats
    where(:id => Classification.find_by(name: "Sailboat").boat_ids.to_a)
  end

  def self.with_three_classifications
    ids = BoatClassification.group(:boat_id).count(:boat_id).select{|id, count| count == 3 }.keys
    where(:id => ids)
  end
end
