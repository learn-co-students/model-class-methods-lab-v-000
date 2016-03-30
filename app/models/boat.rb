class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications
  
  def self.first_five 
    self.all.limit(5)
  end
  
  def self.dinghy
    self.where("length < 20")
  end
  
  def self.ship
    self.where("length >= 20")
  end
  
  def self.last_three_alphabetically
    self.all.order(name: :desc).limit(3)
  end
  
  def self.without_a_captain 
    self.where("captain_id IS NULL")
  end
  
  def self.sailboats 
    self.joins(boat_classifications: :classification).where('classifications.name = "Sailboat"')
  end
  
  def self.with_three_classifications
    # joins the Boat table with the boat_classifications table
    # to count the number of classifications that belong to a 
    # particular boat and selects those boats that have 3 
    # classifications and saves their ids 
    # queries the boats table for boats that match those ids
    boat_ids = self.joins(:boat_classifications).group('boat_classifications.boat_id').count.select { |k,v| v == 3 }.keys
    self.where(id: boat_ids)
  end
    
end
