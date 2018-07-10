class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: ["Catamaran", "catamaran"]})  
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: ["Sailboat", "sailboat"]}).uniq 
  end

  def self.motorboat
    includes(boats: :classifications).where(classifications: {name: ["Motorboat", "motorboat"]}).uniq
  end

  def self.talented_seafarers
    where(id: motorboat.pluck(:id) & sailors.pluck(:id))
  end

  def self.non_sailors
    where.not(id: sailors.pluck(:id))
  end
end
