
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    t = self.where("id < ?", 6)
binding.pry     
  end 
  
end


