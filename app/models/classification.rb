class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  #<Classification id: 1, name: "Ketch", 
  # created_at: "2017-12-15 20:50:47", updated_at: "2017-12-15 20:50:47">
  
  # ["Ketch", "Sailboat", "Catamaran", "Sloop", "Motorboat", "Center Console", "RIB", "Trawler", "Cat Rig Boat", "Bass Boat", "Pontoon Boat"]
  def self.my_all
    select(:name)
  end

  def self.longest
    joins(:boats).where('boats.length = ?',  Classification.joins(:boats).maximum('boats.length'))
  end
end
