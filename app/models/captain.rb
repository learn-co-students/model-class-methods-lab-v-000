class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # search through boats to find catamarans and then return captains of those boats
    find_captains_by_boat_class("Catamaran")
  end

  def self.sailors
    find_captains_by_boat_class("Sailboat")
  end

  def self.talented_seafarers
    motor_captains = find_captains_by_boat_class("Motorboat")
    list = motor_captains & self.sailors
    Captain.where(id: list.map(&:id))
  end

  def self.non_sailors
    # convoluted logic - not sure how to get Classifactions to return ActiveRecord:relation
    binding.pry
    sailboat = Classification.find_by(:name => "Sailboat")
    boats = BoatClassification.find_boats_not_in_classification (sailboat.id)
    captains = boats.map { | boat | boat.captain }.uniq.compact
    Captain.where(id: captains.map(&:id))
  end

  def self.find_captains_by_boat_class (classification_name)
    # convoluted logic - not sure how to get Classifactions to return ActiveRecord:relation
    search = Classification.find_by(:name => classification_name)
    boats = BoatClassification.find_boats_by_classification (search.id)
    captains = boats.map { | boat | boat.captain }.uniq.compact
    Captain.where(id: captains.map(&:id))
  end


end
