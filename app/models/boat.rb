class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.all.limit(5)
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length >= 20")
  end

  def self.last_three_alphabetically
    self.order("name DESC").limit(3)
  end

  def self.without_a_captain
    self.where("captain_id is null")
  end

  def self.find_by_classification(name)
    Classification.find_by_name(name).boats
  end

  def self.sailboats
    find_by_classification("Sailboat")
  end

  def self.catamarans
  	find_by_classification("Catamaran")
  end
  
  def self.motorboats
  	find_by_classification("Motorboat")
  end

  def self.with_three_classifications
    self.where(id: BoatClassification.find_by_number_of_classifications(3))
  end
end
