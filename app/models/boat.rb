class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
     self.limit(5)
   end

   #returns boats < 20ft
   def self.dinghy
     self.where("length < 20")
   end

   #returns boats >20ft
   def self.ship
     self.where("length > 20")
   end

   #returns the last three boats in alphabetical order
   def self.last_three_alphabetically
     self.order(name: :desc).limit(3)
   end

   #returns boats without a captain
   def self.without_a_captain
     self.where(captain: nil)
   end








end
