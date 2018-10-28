class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # captain of boat with classification of Catamaran
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran").uniq
  end

  def self.sailors
    # captain of boat with classification of Sailboat
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboaters
    # captain of boat with classification of Sailboat
    self.joins(boats: [:classifications]).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seafarers
    # captain of boat with classification of Motorboat and Sailboat
    # self.joins(boats: [:classifications]).where("classifications.name = ? or classifications.name = ?", "Catamaran", "Sailboat").uniq #-> NOT Working #
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    # captain of boat which is not classification of Sailboat
    # self.joins(boats: [:classifications]).where.not("classifications.name = ?", "Sailboat").uniq #-> NOTE working #
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
