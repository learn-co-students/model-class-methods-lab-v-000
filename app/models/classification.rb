class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications
   scope :catamarans, -> { where(name: 'Catamaran') }

   def self.my_all
     self.all
   end

   def self.longest
     # binding.pry
     joins(:boats).order("length desc").limit(2)
   end

end
