class Captain < ActiveRecord::Base
  has_many :boats
  
  def self.catamaran_operators
#   Boat.catamarans
      joins(boats: :classifications).where(classifications: {name: "Catamaran"})
       
   
  end
end
