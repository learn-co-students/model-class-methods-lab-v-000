class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:classifications).where(classifications: {name: "Catamaran"})
    captain_ids = boats.map(&:captain_id)
    self.where(id: captain_ids)
  end

  def self.sailors
    captains = Boat.sailboats.map(&:captain_id)
    self.where(id: captains.compact)
  end

  def self.talented_seafarers
    self.joins(:classifications).where(classifications: {name: ["Sailboat"]})

    Boat.sailors.where()
  end
end
