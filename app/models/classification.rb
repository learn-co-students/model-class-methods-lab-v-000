class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    select(:name)
  end

  def self.longest
    # This works but feels wrong
    # joins(:boats).where('boat_classifications.boat_id = ?', Boat.order('length DESC').first)
    # Boat.longest.classifications
  end
end
