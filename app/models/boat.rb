require 'pry'

class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.all.limit(5)
  end

  def self.dinghy
    Boat.where("length < 20")
  end

  def self.ship
    Boat.where("length > 20")
  end

  def self.last_three_alphabetically
    Boat.order("name").reverse_order.limit(3)
  end

  def self.without_a_captain
    Boat.order("captain_id").limit(2)
  end

  def self.sailboats
    joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("count(*) = 3").select("boats.name")
  end


end
