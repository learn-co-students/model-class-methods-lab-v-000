class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end

  def self.sailors
    self.all.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def talented_seafarers
    self.all.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def non_sailors

  end
end
