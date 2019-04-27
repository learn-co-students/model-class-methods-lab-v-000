class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    first(5)
  end

  def self.dinghy
    where("length < ?", 20)
  end

  def self.ship
    where("length >= ?", 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).first(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    includes(:boat_classifications, :classifications).where( "classifications.name = ?", "Sailboat").distinct
  end

  def self.with_three_classifications
    includes(:boat_classifications).having( "COUNT(boat_classifications.boat_id) >= ?", 3).group("boat_classifications.boat_id")
  end

end
