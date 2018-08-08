class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seafarers
    motorboat_captain_ids = Boat.joins(:classifications).where(:classifications => {name: ["Motorboat"]}).pluck(:captain_id)
    sailboat_captain_ids = Boat.joins(:classifications).where(:classifications => {name: ["Sailboat"]}).pluck(:captain_id)
    Captain.where(id: motorboat_captain_ids & sailboat_captain_ids)
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
