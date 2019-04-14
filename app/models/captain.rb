class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    c = includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    d = includes(boats: :classifications).where(classifications: {name: "Sailboat"})
    a = c + d 
    a.select { |z| a.count(z) > 1 }.uniq

  end

  def self.non_sailors
    self.all - self.sailors
  end
end
