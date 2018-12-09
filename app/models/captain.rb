class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    joins(boats: :classifications).where(classifications: {name: "Sailboat", name: "Motorboat"}).uniq
  end

end
