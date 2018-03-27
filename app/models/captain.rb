class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:classifications).where("classifications.name == ?", "Catamaran")
  end

  def self.sailors
    joins(:classifications).where("classifications.name == ?", "Sailboat").uniq
  end

  def self.motorboaters
    joins(:classifications).where("classifications.name == ?", "Motorboat").uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
