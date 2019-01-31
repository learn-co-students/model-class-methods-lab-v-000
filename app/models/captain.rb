class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where('classifications.name' => "Catamaran")
  end

  def self.sailors
    Captain.joins(boats: :classifications).where('classifications.name' => "Sailboat").group('captains.name')
  end

  def self.talented_seafarers
    array = Captain.joins(boats: :classifications).where('classifications.name' => "Sailboat") &
    Captain.joins(boats: :classifications).where('classifications.name' => "Motorboat")
    Captain.where(id: array)
  end

  def self.non_sailors
    sailors = self.sailors
    Captain.where.not(id: sailors)
  end
end
