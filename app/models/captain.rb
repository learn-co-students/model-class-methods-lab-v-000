class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    self.all.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.sailors
    self.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').references(:classifications).uniq
  end

  def self.motorboaters
    all.includes(boats: :classifications).where("classifications.name = 'Motorboat'").references(:classifications).uniq
  end

  def self.talented_seafarers
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    where.not("name IN (?)", self.sailors.pluck(:name))
  end
end
