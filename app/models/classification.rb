class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all.distinct
  end

  def self.longest
    longest_id = Boat.longest.pluck(:id)
    all.joins(:boats).where("boats.id = ?", longest_id)
  end

  def hats
    puts "hats"
  end

end
