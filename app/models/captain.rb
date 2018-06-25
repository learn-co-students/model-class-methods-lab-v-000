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
      Boat.joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}})
    # 2. Who are the captains of those boats?
    # 3. Of those captains, which has more than one boat?
    # 4. Of the captains that have 2+ boats, which boat collections include a sailboat and motorboat?






      # sail_and_motor_ids = Classification.where(name: ["Sailboat", "Motorboat"]).ids

      Boat.joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}})

      Captain.joins(:boats).joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}})




  end

end
