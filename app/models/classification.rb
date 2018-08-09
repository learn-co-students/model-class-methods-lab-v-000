class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

def self.longest
  boat = Boat.all.max {|a,b| a.length <=> b.length }
  boat.classifications
end

end
