class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    # self is implied, so just the 1st 5 results
    limit(5)
  end
  
  def self.dinghy
    where("length < 20")
  end  
  
  def self.ship
    where("length >= 20")
  end
  
  def self.last_three_alphabetically
    # Order by NAME DESC LIMIT 3
    order(name: :desc).limit(3)
  end
  
  def self.without_a_captain
    where(captain: nil)
  end
  
  def self.sailboats
    # JOIN on classifications WHERE name = Sailboat
    joins(:classifications).where(classifications: { name: 'Sailboat' })
  end
  
  def self.with_three_classifications
    # Either of these work
    # JOIN on classifications GROUP BY boat.id HAVING COUNT(*)= 3 SELECT boats.*
    # joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    # JOIN on classifications HAVING COUNT(boat_id) = 3 GROUP BY boat_id
    joins(:classifications).having('COUNT(boat_id) = 3').group('boat_id')
  end
  
  def self.longest
    # ORDER BY length desc LIMIT 1
    order(length: :desc).first
  end
end
