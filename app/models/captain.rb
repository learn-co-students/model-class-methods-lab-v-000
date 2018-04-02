class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
#   Boat.catamarans
      joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end
    def self.sailors

      joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
    end
  
    def self.talented_seafarers

      joins(boats: :classifications).where(classifications: {name: "motorboat"}) && self.sailors
    end
    
    def self.non_sailors

      joins(boats: :classifications).where!(classifications: {name: "Sailboat"})
    end
end
