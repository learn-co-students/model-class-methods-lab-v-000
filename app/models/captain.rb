class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where("classifications.name = 'Catamaran' ").uniq
  end

  def self.sailors
    includes(boats: :classifications).where("classifications.name = 'Sailboat' ").uniq
  end

  def self.motorboaters
    includes(boats: :classifications).where("classifications.name = 'Motorboat' ").uniq
  end

  def self.talented_seafarers
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    where.not("name IN (?)", self.sailors.pluck(:name))
  end
end
