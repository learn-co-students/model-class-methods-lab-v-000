class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(boats: [:classifications]).where("classifications.name = 'Sailboat'").uniq
  end

  def self.talented_seafarers
    self.joins(boats: [:classifications]).group("classifications.id").having("classifications.name = 'Sailboat' OR classifications.name = 'Motorboat'")
  end

  def self.non_sailors
    self.where.not("ID IN (?)", self.sailors.pluck(:id))
  end
end
