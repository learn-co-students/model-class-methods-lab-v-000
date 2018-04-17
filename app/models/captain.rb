class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).group('captains.name')
  end

  def self.motorboat_operators
    self.joins(boats: :classifications).where(classifications: {name: 'Motorboat'})
  end

  def self.talented_seafarers
    self.where('id in (?)', self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    self.where('id not in (?)', self.sailors.pluck(:id))
  end
end
