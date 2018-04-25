class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    self.all.uniq
  end
  
  def self.longest
    boat = Boat.find_by(:length => Boat.maximum("length"))
    ids  = boat.classifications.collect{|c| c.id}
    self.where({:id => ids})
  end
end