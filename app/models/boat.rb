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
    sailboat_id = Classification.find_by(:name => "Sailboat").id
    ids = BoatClassification.where("classification_id = #{sailboat_id}").map(&:boat_id)
    where(:id => ids)
  end
end
