
class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    all
  end
  
  def self.longest
    relation_format = self.none
    longests_classifications = Boat.order(length: :desc).first.classifications
    longests_classifications.each do |classification|
      relation_format << classification
    end
    relation_format
binding.pry 
  end
  
end
