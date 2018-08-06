class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
   limit(5)
 end

 def self.dinghy
   where("length < ?", 20)
 end

 def self.ship
   where("length >= ?", 20)
 end

 def self.last_three_alphabetically
   order(name: :desc).limit(3)
 end

 def self.without_a_captain
   where(:captain_id => nil)
 end

 def self.sailboats
   Boat.joins(:boat_classifications, :classifications).where('classifications.name = ?', 'Sailboat').distinct
 end

 def self.with_three_classifications
   Boat.joins(:boat_classifications).group('boat_id').having('count(boat_classifications.classification_id) = ?', 3)
 end
end
