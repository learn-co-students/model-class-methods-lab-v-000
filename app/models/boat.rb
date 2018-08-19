class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  def self.first_five
    binding.pry
    self.limit(5).pluck(:name)
    Boat.first(5)
  end
end
