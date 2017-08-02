class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  extend ArelTables

  def self.first_five
    self.order(id: :asc).limit(5)
  end

  def self.dinghy
    self.where(boats_arel[:length].lt(20))
  end

  def self.ship
    self.where(boats_arel[:length].gteq(20))
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where(captain: nil)
  end

  def self.sailboats
    self.joins(:classifications).where(classifications_arel[:name].eq("Sailboat"))
  end

  def self.with_three_classifications
    self.joins(:classifications).group(boats_arel[:name]).having(classifications_arel[:id].count.eq(3))
  end
  
end
