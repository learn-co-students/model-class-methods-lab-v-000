class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5).order(:id)
  end

  def self.dinghy
    self.where("LENGTH < ?", 20)
  end

  def self.ship
    self.where("LENGTH >= ?", 20)
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where("captain_id IS NULL")
  end

  def self.sailboats
    self.joins(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    self.joins(:classifications).group("boats.name").having("count(boat_id) = 3")
  end

  def self.long
    self.maximum("length")
  end
end
