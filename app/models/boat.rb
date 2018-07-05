class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
    
    def self.first_five
        self.first(4).each do |boat|
            boat.name
            binding.pry
        end 
    end 
end
