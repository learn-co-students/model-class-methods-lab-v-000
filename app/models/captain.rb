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
    # 1. Which boats are classified as sailboats and which are motorboats?
    # 2. Who are the captains of those boats?
    # 3. Of those captains, which has more than one boat?
    # 4. Of the captains that have 2+ boats, which boat collections include a sailboat and motorboat?

    captains_array = Boat.joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}}).group(:captain_id).having("COUNT(captain_id)>=2").pluck(:captain_id)

    Boat.joins(:captain).where({captains: {id: captains_array}}).order(:captain_id)
    # => #<Boat id: 7, name: "Cape Dory", length: 28, captain_id: 1, created_at: ...
  end

end

Boat.joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}}).group(:captain_id).having("COUNT(captain_id)>=2").joins(:captain).order(:captain_id)
