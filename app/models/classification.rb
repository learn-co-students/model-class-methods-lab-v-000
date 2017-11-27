class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where("id IS NOT NULL")
  end

  def self.longest

    joins(:boats).order("boats.length DESC").limit(2)
  end

end
