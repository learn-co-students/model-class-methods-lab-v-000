class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
#   Boat.catamarans
      joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end
    def self.sailors

      joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    end
    
  def self.motorboat_operators
      joins(boats: :classifications).where(classifications: {name: "Motorboat"})
  end
  
    def self.talented_seafarers
    #   self.motorboat_operators && self.sailors
    where("id IN (?)", self.sailors.select(:id) & self.motorboat_operators.select(:id))
    
    end
    
    def self.non_sailors

      joins(boats: :classifications).where!(classifications: {name: "Sailboat"})
    end
end
