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
    motorboats = Boat.joins(:classifications).where(classifications: {name: ["Motorboat"]})
    motorboat_captains = motorboats.map(&:captain_id)
    sailors = self.sailors.pluck(:id)
    all = motorboat_captains & sailors
    self.where(id: all)
  end

  def self.non_sailors
    self.where.not(id: self.sailors)
  end
end
