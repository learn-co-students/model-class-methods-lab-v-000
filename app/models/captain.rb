class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.join_classifications
    joins("INNER JOIN boats b ON b.captain_id = captains.id INNER JOIN boat_classifications bc ON bc.boat_id = b.id INNER JOIN classifications c ON c.id = bc.classification_id")
  end

  def self.catamaran_operators
    self.join_classifications.where("c.name = 'Catamaran'")
  end

  def self.sailors
    self.join_classifications.where("c.name = 'Sailboat'").distinct
  end

  def self.talented_seafarers
    self.join_classifications.group("captains.id").where("c.name = 'Motorboat' AND c.name = 'Sailboat'")
  end

end
