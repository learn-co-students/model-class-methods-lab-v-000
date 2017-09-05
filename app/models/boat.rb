class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    Boat.where(Boat.arel_table[:id].lteq(5))
  end

  def self.dinghy
    Boat.where(Boat.arel_table[:length].lt(20))
  end

  def self.ship
    Boat.where(Boat.arel_table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    Boat.order(Boat.arel_table[:name].desc).take(3)
  end
end
