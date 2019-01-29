class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end 
  
  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end 
  
  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end 
  
  
  def self.talented_seafarers #Motorboats and sailboats
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    #includes(boats: :classifications).where({classifications: {name: "Motorboat || Sailboat"}, captains: {id: captains}})
    #Captain.includes(boats: :classifications).where({classifications: {name: "Motorboat || Sailboat"}})  
     #joins(:boats).group("boats.id").having("LENGTH(*)").select("boats.*")

     #Captain.joins(:boats).where("id IN (?)", pluck(:name))  group(""Motorboat || Sailboat").pluck(:name)
  end 
  
  def self.non_sailors #use pluck method
    #binding.pry
    Captain.where.not("id IN (?)", sailors.pluck(:id))
  end
  
end 
