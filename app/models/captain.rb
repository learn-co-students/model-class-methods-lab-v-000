class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # SELECT * FROM captains
    # LEFT JOIN boats ON captains.id = boats.captain_id
    # LEFT JOIN boat_classifications ON boats.id = boat_classifications.boat_id
    # LEFT JOIN classifications ON classifications.id = boat_classifications.classification_id
    # WHERE classifications.name = "Catamaran"
    joins(boats: :classifications).where({ classifications: {name: "Catamaran"}})
  end

  def self.sailors
    joins(boats: :classifications).where({ classifications: {name: "Sailboat"}}).distinct
  end

  def self.motorboaters
    joins(boats: :classifications).where({ classifications: {name: "Motorboat"}}).distinct
  end

  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
