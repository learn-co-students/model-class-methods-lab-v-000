class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
 def self.first_five
    Boat.limit(5)
  end

  def self.dinghy
    Boat.where("length < ?", 20)
  end

  def self.ship
    Boat.where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    Boat.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    Boat.where(captain_id: nil)
  end

  def self.sailboats
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    includes(:classifications).group("boats.id").having("count(*) = 3")
  end

  def self.longest
    order(length: :desc).first
  end
end
