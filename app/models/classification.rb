class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select("*")
  end

  def self.longest
    binding.pry
    joins(:boats).group("classifications.name").having("MAX(boats.length)").order("boats.length DESC") 
    # .group(:id).having("Max(boats.length)")
  end
end
