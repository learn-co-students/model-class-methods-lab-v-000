class Classification < ActiveRecord::Base
# t.string :name
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

# returns all classifications
  def self.my_all
    Classification.all
  end

# returns the classifications for the longest boat
  def self.longest
    Boat.where(:length => Boat.maximum(:length)).first.classifications
  end
end
