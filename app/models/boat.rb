class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
    #just pick the first 5 boats
  end

  def self.dinghy
    where("length < 20")
    #grab all boats where length is less than 20 ft
  end

  def self.ship
    where("length >= 20")
    #grab all boats where length is less than 20 ft
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
    #you can order with .order
    #arguments: what you want to order by, then as or desc
    #will order by name in descending alph. order, give last three
  end

  def self.without_a_captain
    where(captain_id: nil)
    #captain id is nil, there is no captain id associated
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: 'Sailboat' })
    ##? includes all where classifications == sailboat
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    #join classifications and boats table
    #group by boat id
    #select all boats where count of classifications is three?
  end

  def self.longest
    order('length DESC').first
    #order by longest
  end
end
