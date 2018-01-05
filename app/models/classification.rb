class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where("")
  end

  def self.longest
    len = joins(:boats).maximum("boats.length")
    joins(:boats).where("boats.length = #{len}")
  end 
end
