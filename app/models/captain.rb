class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end


  def self.motorboateers
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end
 
  def self.talented_seamen
    where("id IN (?)", self.sailors.select(:id) & self.motorboateers.select(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
