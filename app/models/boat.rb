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


  def self.sailboats
    Boat.joins(:classifications)
  end

  def self.with_three_classifications
    find_by_sql("SELECT boat_id FROM boat_classifications WHERE COUNT(boat_id) >2")
  end
end
