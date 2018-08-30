
class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    all
  end
  
  def self.longest
<<<<<<< HEAD
    Boat.longest.classifications
=======
    # Boat.order(length: :desc).first.classifications
binding.pry 
>>>>>>> e42fd7cd2cd588d03b401a2289b86783a520e46b
  end
  
end
