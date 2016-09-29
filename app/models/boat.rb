class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5).order('created_at asc')
  end

  def self.dinghy
    self.where(table[:length].lt(20))
  end

  def self.ship
    self.where(table[:length].gt(20))
  end

  def self.last_three_alphabetically
    self.limit(3).order('name desc')
  end

  def self.without_a_captain
    self.where(table[:captain_id].eq(nil))
  end

  def self.sailboats
    Boat.joins(:classifications).where(:classifications => {:name => "Sailboat"}).all
  end
 
  def self.with_three_classifications
    Boat.joins(:classifications).group("boats.id").having("count(*) = 3")
  end



  def self.table
    Boat.arel_table
  end
end
