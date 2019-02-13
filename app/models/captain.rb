class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where("classifications.name = 'Catamaran'").distinct
  end

  def self.sailors
   self.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').references(:classifications).uniq
  end

  def self.motorboats
    self.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').references(:classifications).uniq
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    where.not("name IN (?)", self.sailors.pluck(:name))
  end

end
