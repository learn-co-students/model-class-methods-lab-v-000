class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

#this method not in the test, but used to build #talented_seafarers
  def self.motormen
      includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    end

  def self.talented_seafarers
    where(id: self.sailors & self.motormen)
  end

  def self.non_sailors
    where(id: self.all-self.sailors)
  end

end
