class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.sailors
    self.joins(boats: [:classifications]).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.talented_seafarers
    self.joins(boats: [:classifications]).where(classifications: {name: 'Motorboat'})
  end

#breaking bc it's testing for any of the boats??
  def self.non_sailors
    binding.pry
    self.joins(boats: [:classifications]).where.not(classifications: {name: 'Sailboat'})
  end
end
