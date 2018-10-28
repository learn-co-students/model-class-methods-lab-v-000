class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.talented_seafarers
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: { name: 'Catamaran' })
  end
end
