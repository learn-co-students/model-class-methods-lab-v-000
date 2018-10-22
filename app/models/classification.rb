class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    # binding.pry
    all
  end

  def self.longest
    joins(:boats).order(Boat.arel_table[:length].desc).uniq.limit(2)
  end
end
