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
    # returns captains of motorboats and sailboats
    # 1. find all motorboats and sailboats ids
      # class_ids_array = Classification.where(name: ["Sailboat", "Motorboat"]).pluck(:id) #=> [2, 5]
    # 2. find all boats that are either motorboats or sailboats
    # class_ids = Classification.where(name: ["Sailboat", "Motorboat"]).pluck(:id)
    # boat_class_combos = BoatClassification.where(classification_id: class_ids).pluck(:boat_id)



      Boat.joins(:classifications).where({classifications: {name: ["Sailboat", "Motorboat"]}}).pluck(:boat_id)
    # 3. find captains that have more than one boat
    # 4. captains where at least one of their boats is a motorboat and at least one is a sailboat




    # Classification.joins(:boats).where(name: ["Sailboat", "Motorboat"]).group(:boat_id)
  end

end
