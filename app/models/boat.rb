class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length > 20")
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where("captain_id is null")
  end

  def self.sailboats
    # sailboat_classification = Classification.find_by(name: "Sailboat")
    # self.all.select{|boat| boat.classifications.include?(sailboat_classification)}
    #More efficient
    # self.joins("join boat_classifications on boats.id = boat_classifications.boat_id join classifications on boat_classifications.classification_id = classifications.id").where("classifications.name = 'Sailboat'")
    self.joins(:boat_classifications).joins(:classifications).where("classifications.name = 'Sailboat'").distinct
  end

  def self.with_three_classifications
     self.joins(:boat_classifications).group('boats.id').having('count(classification_id) = 3')
  end
end
