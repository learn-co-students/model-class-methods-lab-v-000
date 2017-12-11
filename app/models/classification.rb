class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
  
  def self.my_all
    Classification.all
  end
  
  def self.longest
    temp_max = Classification.first.boats.first
    max = Classification.first.boats.first
    
    Classification.all.each do |classification|
      temp_max = classification.boats.max_by{|boat| boat.length}
      if temp_max.length > max.length
        max = temp_max
      end
    end
    max.classifications
  end
end
