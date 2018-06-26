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

  def self.talented_seafarers
    motorboats = Boat.joins(:classifications).where({classifications: { name: "Motorboat"}})
    # motorboats => [3, 4, 5, 7, 9, 10]
    sailboats = Boat.joins(:classifications).where({classifications: { name: "Sailboat" }})
    # sailboats => [1, 2, 6, 8, 11, 12]

    where(id: sailboats).where(id: motorboats)
    # binding.pry
    # find the captains WHERE the captain.id == boat.captain_id

  end

end
