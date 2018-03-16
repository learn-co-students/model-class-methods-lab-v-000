class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    Boat.longest.classifications
  end
  # easier to break the method in two parts where in the Boat model you check for
  # the longest boat by order and then calling the method here to ask for
  # its classifications
end
