class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all.uniq
  end

  def self.longest
     joins(:boats).where({ boats: {length: Boat.max_length} })
   end
end
