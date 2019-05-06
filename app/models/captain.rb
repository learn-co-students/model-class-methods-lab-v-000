class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:boats).where(boats: {name: "Catamaran"}).distinct
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    sailors.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.non_sailors
    includes(boats: :classifications).where.not(classifications: {name: "Sailboat"}).distinct
  end
end
