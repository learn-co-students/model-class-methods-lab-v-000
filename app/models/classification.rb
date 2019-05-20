class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    where.not(name: nil)
  end

  def self.longest
    binding.pry
    where(id: Boat.longest)
  end
end
