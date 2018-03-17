class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # this doesn't pass test bc it's not an AR query, but it works => self.all.select(&:name)
    self.all
  end

  def self.longest
    # self.joins(:boats).order("length DESC").limit(2)

    # solution on learn
    # #longest method defined in Boat
    Boat.longest.classifications

    # alternate solution:
    # Boat.order('length DESC').first.classifications
  end
end
