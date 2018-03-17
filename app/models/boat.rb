class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def classification_names
    self.classifications.map {|x| x.name }
  end

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
    where(captain: nil)
  end

  def self.sailboats
    joins(:classifications).where("classifications.name = 'Sailboat'")
  end

  def self.catamarans
    joins(:classifications).where("classifications.name = 'Catamaran'").select("captain_id")
  end

  def self.with_three_classifications
    boats = self.all.select {|boat| boat.classifications.count == 3}
    boat_ids = boats.map{ |x| x.id }
    where(id: boat_ids)
  end
end
