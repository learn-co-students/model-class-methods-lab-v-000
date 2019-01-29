class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all #returns all classifications 
    Classification.all
  end 
  
  def self.longest
    Boat.longest.classifications
    #classification_ids = BoatClassification.longest_boat_classifications 
    #where(id: classification_ids)
  end 
  
#Classification.joins(:boat_classifications).order("boats.length")
#includes(:boat_classifications).group(:boats).order("boats.length")
#joins(:boats).group("boats.length").first  
#includes(:boats).group("boats.id").order("boat.length").where(boat: "length 20")  
#includes(:boats).where(boats: {'length DESC'})
#order('length DESC').first
#User.joins("LEFT JOIN bookmarks ON bookmarks.bookmarkable_type = 
end 

