class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)      
   end

   def self.dinghy
    self.where("length <' 20'")
   end

   def self.ship
    self.where("length >= '20'")
  end

  def self.last_three_alphabetically
    self.order('name desc').limit(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    classification_id_sailboat = Classification.all.where(name: "Sailboat").pluck(:id)
    BoatClassification.where(classification_id: classification_id_sailboat)                                                                                    
#find boat_ids where BoatClassification' classification_id = classification_id_sailboat
    binding.pry
  end

end
 # binding.pry
    # self.order('name DESC')[0 , 3].map {|b|b.name}  