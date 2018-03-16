class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  # #<Boat id: 1, name: "H 28", length: 27, captain_id: 1, 
  # created_at: "2017-12-15 20:50:47", updated_at: "2017-12-15 20:50:47">

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < ? ", 20)
  end

  def self.ship
    where("length >= ? ", 20)
  end  

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.with_three_classifications
    joins(:classifications).group('boat_id').having('COUNT(boat_id) = 3')
  end
end
