class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    joins(:boats)
  end

  def self.longest
    joins(:boats).order("boats.length DESC").limit(2)
  end

end
