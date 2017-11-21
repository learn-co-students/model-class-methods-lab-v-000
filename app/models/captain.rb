class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboators
    joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    both = self.sailors.pluck(:id) & self.motorboators.pluck(:id)
    where(id: both)
  end

  def self.non_sailors
    sailors = self.sailors.pluck(:id)
    where.not(id: sailors)
  end


end
