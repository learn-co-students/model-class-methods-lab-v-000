class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
    #all of the boats limited to just the first five
  end

  def self.dinghy
    where("length < '20'")
  end

  def self.ship
    where("length >= '20'")
    #all of the boats where the length attribute of the boat is > 20
  end

  def self.last_three_alphabetically
    all.order(name: :desc).limit(3)
    #all of the boats, ordered by name, limited to 3
  end

  def self.without_a_captain
    where(captain: nil)
    #all of the boats where the captain attribute is nil
  end

  def self.sailboats
    #all boats where classifications includes a classifcation that has a name of 'Sailboat'
    #self.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    #all of the boats where the number of classifications is equal to 3
    #where the size of the classifications collection is 3

    #joins the classifications table onto the current table (this gives you access to the join table boat_classifications)
    #this gives you the ability to query the boat_classifications for the connection between boats and their classifications
    #you can also place conditions on what it returns with the .having statement
    #the .having statement returns a collection grouped by boats.id where each boat must have 3 classifications
    #it counts the classfications for each boat_id and for the ones that are equal to three, it returns them
    #from that collection of boats, it selects all of the boats
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

  end

  def self.longest_boat
    byebug
    #order by length
    #get the first one
  end
end
