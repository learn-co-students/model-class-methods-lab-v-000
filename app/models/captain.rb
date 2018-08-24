class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
    includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seafarers
    where("name IN (?)", self.sailors.pluck(:name) & self.motorboat_operators.pluck(:name))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
