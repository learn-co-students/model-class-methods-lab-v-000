class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    all.order("name DESC").limit(3)
  end

  def self.without_a_captain
    where(captain: nil)
  end

  def self.sailboats
    all.joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.with_three_classifications
    all.joins(:boat_classifications).group("boats.name").having("count(boat_classifications.id) = 3")
  end

end
