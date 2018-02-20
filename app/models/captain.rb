class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).group('captains.id').where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    Captain.joins(boats: :classifications).group('captains.id').where(classifications: { name: "Sailboat" })
  end

  def self.motorists
    Captain.joins(boats: :classifications).group('captains.id').where(classifications: { name: "Motorboat" })
  end

  def self.talented_seafarers
    Captain.where('id IN (?)', self.sailors.pluck(:id) & self.motorists.pluck(:id))
  end

  def self.non_sailors
    Captain.where('id NOT IN (?)', self.sailors.pluck(:id) || self.motorists.pluck(:id))
  end
end
