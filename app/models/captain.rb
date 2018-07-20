class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats
    joins(boats: :classifications).where(classifications: {name: "Motorboat"})
  end


  def self.talented_seafarers
     where("name IN (?)", sailors.pluck(:name) & motorboats.pluck(:name))
  end

  def self.non_sailors
    where("name NOT IN (?)", sailors.pluck(:name))
  end
end
