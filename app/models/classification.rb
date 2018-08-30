
class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
binding.pry 
  end
  
  def self.longest
binding.pry 
  end
  
end
