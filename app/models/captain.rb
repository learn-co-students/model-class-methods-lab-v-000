class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # captain of boat with classification of Catamaran
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    # captain of boat with classification of Sailboat
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboats
    # captain of boat with classification of Sailboat
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.talented_seafarers
    # captain of boat with classification of Motorboat and Sailboat
    self.joins(boats: [:classifications]).where("classifications.name = ? or classifications.name = ?", "Catamaran", "Sailboat").uniq
  end

  def self.non_sailors
    # captain of boat which is not classification of Sailboat
    # self.joins(boats: [:classifications]).where.not("classifications.name = ?", "Sailboat").uniq
    where.not(id: self.sailors.pluck(:id))
  end

end
