class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: {boat_classifications: :classification}).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name = ?", "Sailboat").distinct
  end

  def self.talented_seafarers
    self.joins(boats: {boat_classifications: :classification}).where(classifications: {name: ["Sailboats", "Motorboats"]})
  end

  def self.non_sailors
    self.joins(boats: {boat_classifications: :classification}).where("classifications.name != ?", "Sailboat").distinct
  end
end
