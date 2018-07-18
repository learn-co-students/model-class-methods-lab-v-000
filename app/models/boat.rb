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
    where("length>=20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where("captain_id IS NULL")
  end

  def self.sailboats
    #joins automatically performs the requisite joins in the sql using the relationship above
    #where classifications.name="Sailboat" actually performs the wuere.
    joins(:classifications).where("classifications.name='Sailboat'")
  end

  def self.get_by_classification(classification)
    joins(:classifications).where("classifications.name=?",classification)
  end

  def self.with_three_classifications
    #joins automatically performs the joins as stated above
    #group by boats.id should just have one row per boat, rather than one per classification (?)
    #having count boats.id 3 means that the count of how many times the boat shows up is 3
    #If we hadn't asked for it, the count of boat.id instances would not have be used for anything.
    joins(:classifications).group("boats.id").having("count(boats.id) = 3")
  end

  def self.longest
    Boat.order(length: :desc).first
  end








end
