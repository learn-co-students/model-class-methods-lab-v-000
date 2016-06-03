class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5).order('created_at ASC')
  end

  def self.dinghy
    where(boat[:length].lt(20))     
  end

  def self.ship
    where(boat[:length].gteq(20))
  end

  def self.last_three_alphabetically
    select(:all).order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(boat[:captain_id].eq(nil))  
  end

  def self.sailboats
    self.joins(:classifications).merge(Classification.where(name: 'Sailboat'))
  end

  def self.with_three_classifications
    # SELECT boats.* FROM boats
    # INNER JOIN boat_classifications ON boat_classifications.boat_id = boats.id
    # HAVING COUNT(boat_classifications.boat_id) > 2
    #
    # This works:
    # joins(:boat_classifications).having('COUNT(boat_classifications.boat_id) > 2').group('boats.id')
    
    boat_classification = BoatClassification.arel_table
    
    # This works: 
    # joins(:boat_classifications).having(boat_classification[:boat_id].count.gteq(3)).group('boats.id')

    # This works:
    three_or_more = boat_classification.
                      project(boat_classification[:boat_id]).
                      group(boat_classification[:boat_id]).
                      having(boat_classification[:boat_id].
                      count.gteq(3))
    where(boat[:id].in(three_or_more))
  end


  def self.boat
    Boat.arel_table
  end
end
