
class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five
    
binding.pry    

    # take(5)
  end 
  
end

# self.connection.select_all("


SELECT * FROM boats WHERE id < '6'

")