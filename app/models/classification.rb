class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    self.all
  end
  
  def self.longest 
    # finds the id of the longest boat
    longest_boat_id = Boat.order(length: :desc).first.id
    # joins classifications with boats and filters only those 
    # classifications which match the boat_id of the longest boat
    self.joins(boat_classifications: :boat).where("boats.id = ?", longest_boat_id)
  end
  
end
