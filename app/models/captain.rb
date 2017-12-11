class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: { name: "Catamaran" }) 
  end
  
  def self.sailors
    Captain.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq 
  end
  
  def self.motorboaters
    Captain.joins(boats: :classifications).where(classifications: { name: "Motorboat" }).uniq 
  end
  
  def self.talented_seamen
    Captain.where("id IN (?)", Captain.sailors.pluck(:id) & Captain.motorboaters.pluck(:id))
  end
  
  def self.non_sailors
    Captain.where.not("id IN (?)", Captain.sailors.pluck(:id))
  end
end
