class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # 1. find boats classified as catamarans
    # 2. find those boat's captain_ids
    ids_array = Boat.joins(:classifications).where({classifications: { name: "Catamaran" }}).pluck(:captain_id)
    # 3. find captains with ids matching the boats' captain_ids
    where(id: ids_array)
  end

  def self.sailors
    # returns captains with sailboats
    ids_array = Boat.joins(:classifications).where({classifications: { name: "Sailboat" }}).pluck(:captain_id)
    where(id: ids_array)
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
