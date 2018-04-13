class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.sailors
    self.joins(boats: [:classifications]).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.motorists
    self.joins(boats: [:classifications]).where(classifications: {name: 'Motorboat'}).distinct
  end

  def self.talented_seafarers
    # self.sailors & self.motorists union but is an array. the test uses pluck, so have to convert it to activerecord:relation via this ugliness... 
    self.where(id: (self.sailors & self.motorists).map(&:id))
  end

#breaking bc it's testing for any of the boats??
  def self.non_sailors
    self.where.not(id: self.sailors.map(&:id))
  end
end
