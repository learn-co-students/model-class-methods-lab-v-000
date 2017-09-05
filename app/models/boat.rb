class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def table
    Boat.arel_table
  end

  boats = Arel::Table.new(:boats)

  def self.first_five
    Boat.where(Boat.arel_table[:id].lteq(5))
  end

  def self.dinghy
    Boat.where(Boat.arel_table[:length].lteq(20))
  end

end
