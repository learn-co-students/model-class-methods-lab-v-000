class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.select("*").distinct
  end

  def self.longest
    # binding.pry
    longest_boat = Boat.order(length: :desc).first.name
    includes(:boats).where("boats.name = ?", longest_boat).references(:boats)
  end
end
