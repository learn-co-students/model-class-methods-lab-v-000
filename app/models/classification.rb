class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select("*")
  end

  def self.longest
    joins(:boats).where("boat_id =?", "#{Boat.order('length DESC').limit(1).pluck('id').first}")
  end
end
