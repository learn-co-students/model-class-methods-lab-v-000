class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
      self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end
  
  def self.sailors
      self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end
  
  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
  
end


#needed a lot of help on this one, vaguely understand but really could use a study guide or office hours