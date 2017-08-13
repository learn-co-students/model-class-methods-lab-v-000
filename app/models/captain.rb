class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboaters
    all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seamen
    all.where("id IN (?)", self.sailors & self.motorboaters)
  end

  def self.non_sailors
    all.where.not("id IN (?)", self.sailors.pluck(:id))
  end


    
end
