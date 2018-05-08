class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
    #all of the boats limited to just the first five
  end

  def self.dinghy
    self.where("length < '20'")
  end

  def self.ship
    self.where("length >= '20'")
    #all of the boats where the length attribute of the boat is > 20
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
    #all of the boats, ordered by name, limited to 3
  end

  def self.without_a_captain
    self.where(captain: nil)
    #all of the boats where the captain attribute is nil
  end

  def self.sailboats
    #all boats where classifications includes a classifcation that has a name of 'Sailboat'
    self.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications)
  end

  def self.with_three_classifications
    #all of the boats where the number of classifications is equal to 3
    #where the size of the classifications collection is 3
    byebug
    self.includes(:classifications).where('classifications.size > ?', '3').references(:classifications)
  end
end
