class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    Classification.all
    #returns all classifications
  end

  def self.longest
    boat= Boat.limit(1).order(:length => :desc)
    classifications = boat[0].classifications #[0] takes it out of AR association
    #test doesn't want the names, just the objects
    #the classifications for the longest boat
  end

end
