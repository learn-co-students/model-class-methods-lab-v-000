class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.talented_seafarers
    where(id: self.sailors & self.motorboaters)
  end

  def self.motorboaters
    includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.non_sailors
    where(id: self.all - self.sailors).distinct
  end
end
