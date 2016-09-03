class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

 def self.longest
    Boat.longest.first.classifications
  end

end



#  limit(3).order(name: :desc) 
# end

# def self.without_a_captain
#   where(captain_id: nil)
# end

# def self.sailboats
#   joins(:classifications).where('classifications.name' => "Sailboat")