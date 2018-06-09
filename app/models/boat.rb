class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
    #Notice how we can use the method all, as in Boat.all
    #but we don't need to do anything but use "all" because of "self": 
    #because it's a class method
  end

  def self.dinghy
    all.where("length < 20")
  end

  def self.ship
    where("length >= 20")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
    #Note that name is shown as a key here -- bec. SQL
    #Is it better to use all when it can be used or not when it doesn't have to be?
    #  Also, does it ever have to be?
  end

  def self.without_a_captain
    where(captain_id: nil)
    #don't think of iteration/high-load ways; think about how models are 
    #connected and consider the basic processes you know to find simple solutions
    #for just figuring out if something exists or not
  end

  def self.sailboats
    includes(:classifications).where(classifications: { name: "Sailboat"} )
  end

  def self.with_three_classifications
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  #Does joins(:classifications) join with the Boat model class represented by self in the method signature?
  #group (and not "group by") uses boats.id as normal SQL but doesn't need the other model 
  #  bec. it's here already, represented by self
  #don't really understand this at all, esp. the * in "boats.*": "having("COUNT(*) = 3").select("boats.*")"
  # and how can it count three that have each of three kinds based on id? shouldn't it be three different names?
  end

  def self.longest
    order("length DESC").first
    # in "returns the classifications for the longest boat" in the test, classification is plural
    #  for a reason ... because classifications ... a ??? ... an associated class ??? ... is being called as a method on the longest Boat object
    # WHy does this work with order("length DESC").first and not "order(length: :desc).limit(1)"?

    #SEPARATION OF CONCERNS!!!
  end
end


