class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.all.select {|boat| boat.classifications.any? {|classification| classification.name == "Catamaran" }}
    captain_ids = boats.map {|boat| boat.captain_id}
    where(id: captain_ids)
  end

  def self.sailors
    boats = Boat.all.select {|boat| boat.classifications.any? {|classification| classification.name == "Sailboat" }}
    captain_ids = boats.map {|boat| boat.captain_id}
    where(id: captain_ids)
  end

  def self.talented_seamen
    sailboats = Boat.all.select {|boat| boat.classifications.any? {|classification| classification.name == "Sailboat"}}

    motorboats = Boat.all.select {|boat| boat.classifications.any? {|classification| classification.name == "Motorboat"}}

    captain_ids_sailboats = sailboats.map {|boat| boat.captain_id}
    captain_ids_motorboats = motorboats.map {|boat| boat.captain_id}

    where(id: captain_ids_sailboats).where(id: captain_ids_motorboats)
  end

  def self.non_sailors
    boats = Boat.all.select {|boat| boat.classifications.include?(Classification.find_by_name("Sailboat"))}
    captain_ids = boats.map {|boat| boat.captain_id}
    where.not(id: captain_ids)
  end
end
