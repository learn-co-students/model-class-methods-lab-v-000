class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select("*")
  end

  def self.longest
    joins(:boats).order("boats.length")
  end
end
