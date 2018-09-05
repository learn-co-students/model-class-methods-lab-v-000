class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(:classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    includes(:classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboaters
    includes(:classifications).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
