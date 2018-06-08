class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #1. select all captains who have boats /w classifications
    #2. classifications that have name catamaran
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    #same as above, take captain once
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seafarers
    #where id INTEGER is all sailors in SAILORS and MOTORBOAT_OPERATORS
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
