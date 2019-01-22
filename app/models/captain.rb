class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    self.includes(boats: :classifications).uniq.where(classifications: { name: 'Sailboat' })
  end

  def self.motorboat_captains
    self.includes(boats: :classifications).uniq.where(classifications: { name: 'Motorboat' })
  end

  def self.talented_seafarers
    where("id in (?)", self.sailors.pluck(:id) & self.motorboat_captains.pluck(:id))
  end

  def self.non_sailors
    where("id not in (?)", self.sailors.pluck(:id))
  end

end
