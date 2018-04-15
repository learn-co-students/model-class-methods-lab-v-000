class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: 'Catamaran'}).uniq
  end
  def self.sailors

    self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end
  def self.talented_seafarers
    self.joins(boats: :classifications).where(classifications: {name: ['Sailboat', 'Motorboat']}).group('classifications.id').uniq
  end
  def self.non_sailors
    # binding.pry
    self.joins(boats: :classifications).where('classifications.name != ?', 'Sailboat').order('classifications.id').uniq
  end
end
