class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    binding.pry
    Boat.take(5)
  end

  # private

  # def self.table
  #   Boat.arel_table
  # end
end
