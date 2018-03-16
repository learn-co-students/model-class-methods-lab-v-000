class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end 

  def self.sailors 
    Captain.includes(boats: :classifications).where(classifications: {name: 'Sailboat'}).uniq
  end 

  def self.motorboat_captains
    Captain.includes(boats: :classifications).where(classifications: {name: 'Motorboat'}).uniq
  end 

  def self.talented_seamen
    Captain.where("id IN (?)", sailors.pluck(:id) & motorboat_captains.pluck(:id)) 
  end 

  def self.non_sailors 
    where.not("id IN (?)", self.sailors.pluck(:id))
  end 
  

  
  
  
end
