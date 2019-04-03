class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order("name DESC").limit(3)
  end

  def self.without_a_captain
    where(captain_id: [nil, ""])
  end

  def self.sailboats
    sailboat_classification = Classification.select_classifications("Sailboat")
    sailboat_classification.boats
  end

  def self.with_three_classifications
    boats = []
    Boat.all.each do |boat|
      if boat.classifications.length == 3
        boats << boat
      end
    end
    boats
  end

  def self.longest
    order("length DESC").limit(1).first
  end

  #def self.sailboats
  #  includes(:classifications).where(classifications: { name: 'Sailboat' })
  #end

  #def self.with_three_classifications
  #  joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  #end


end
