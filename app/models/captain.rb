class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: [{classifications: :boat_classifications }]).where('classifications.name = "Catamaran"').uniq
  end

  def self.sailors
    Captain.joins(boats: [{classifications: :boat_classifications }]).where('classifications.name = "Sailboat"').uniq
  end

  def self.motorboat
    Captain.joins(boats: [{classifications: :boat_classifications }]).where('classifications.name = "Motorboat"').uniq
  end

  def self.talented_seamen
    Captain.where("id IN (?)", Captain.motorboat.pluck(:id) & Captain.sailors.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)",Captain.sailors.pluck(:id))
  end
end

