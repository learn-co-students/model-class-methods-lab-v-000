class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.table
    Boat.arel_table
  end

  def self.dinghy
    where(table[:length].lt(20))
  end

  def self.ship
    where(table[:length].gteq(20))
  end

  def self.last_three_alphabetically
    self.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(table[:captain_id].eq(nil))
  end

  def self.sailboats
    self.joins(:classifications).merge(Classification.where(name: 'Sailboat'))
  end

  def self.with_three_classifications
    # SELECT boats.* FROM boats
    # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    # HAVING COUNT(boat_classifications.boat_id) > 2
    # I had to cheat on this one...

    self.joins(:boat_classifications).having('COUNT(boat_classifications.boat_id)>2').group('boats.id')
  end

end
