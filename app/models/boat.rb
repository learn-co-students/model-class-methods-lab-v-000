class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length <?", 20)
  end

  def self.ship
    where("length >=?", 20)
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    #binding.pry
    #sailboat_id = Classification.find_by(name: "Sailboat").id
    #self.all.select { |boat| boat.classifications.include?(Classification.find_by(name: "Sailboat"))}
    includes(:classifications).where(classifications: {name: "Sailboat"})
  end

  def self.with_three_classifications
    #binding.pry
    #includes(:classifications).having("classifications =?",3)
    #having("boat_classifications = 3")
    #joins("boat_classifications").where("boat_classifications == 3")
    #self.all.select { |boat| boat.classifications.count == 3}
    joins(:classifications).group(:boat_id).having("count(boat_id) = 3")
    #select("* count(group(boat_id)")
  end
end
