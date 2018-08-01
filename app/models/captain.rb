class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # search through boats to find catamarans and then return captains of those boats
#    find_captains_by_boat_class("Catamaran")
    includes(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
#    find_captains_by_boat_class("Sailboat")
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    # motor_captains = find_captains_by_boat_class("Motorboat")
    # list = motor_captains & self.sailors
    # Captain.where(id: list.map(&:id))
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    # inefficient implementation - really want SQL query to pull all the captains that
    # don't have any sailboats...
    # list = self.all - self.sailors
    # Captain.where(id: list.map(&:id))
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

  # Only needed for convoluted implementations commented out above
  # def self.find_captains_by_boat_class (classification_name)
  #   # convoluted logic - not sure how to get Classifactions to return ActiveRecord:relation
  #   search = Classification.find_by(:name => classification_name)
  #   boats = BoatClassification.find_boats_by_classification (search.id)
  #   captains = boats.map { | boat | boat.captain }.uniq.compact
  #   Captain.where(id: captains.map(&:id))
  # end


end
