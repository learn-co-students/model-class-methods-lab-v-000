class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
     Boat.all.limit(5)
    end

  def self.dinghy
    # returns boats shorter than 20 feet
    Boat.where("length < 20")
  end

  def self.ship
    # return boats 20 feet or longer
    Boat.where("length > 20")

  end

  def self.last_three_alphabetically
    # returns last three boats in alphabetical order
    Boat.all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    #returns boats wiout a captian
    Boat.where(captain_id: nil)
    end

  def self.sailboats
    # returns all boats that are sailboats
    Boat.includes(:classifications).where(classifications: { name: 'Sailboat' })

  end

  def self.with_three_classifications
    #return boats with three classifications
    self.joins(:classifications).group("boats.id").having("COUNT(*) = 3")     
   end

   def self.longest
     Boat.order("length DESC").first
   end

end
