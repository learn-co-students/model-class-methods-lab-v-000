class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.motorboat_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.non_sailors
    ids = self.sailors.pluck(:id)
    # Captain.joins(boats: :classifications).where.not(classifications: {name: "Sailboat"}).distinct
    # ids = Boat.non_sailboats.pluck(:captain_id)
    # where("id IN (?)", ids)
    where.not(id: ids)
  end

end
