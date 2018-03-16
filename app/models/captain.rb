class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamaran = Classification.where(name: 'Catamaran')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

    captain_ids = []
    boat.to_a.each do |boat|
      captain_ids << boat.captain_id
    end

    Captain.where(id: captain_ids)
  end

  def self.sailors
    catamaran = Classification.where(name: 'Sailboat')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

    captain_ids = []
    boat.to_a.each do |boat|
      captain_ids << boat.captain_id
    end

    Captain.where(id: captain_ids)
  end

  def self.talented_seamen
    catamaran = Classification.where(name: 'Sailboat')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

    sailboat_ids = []
    boat.to_a.each do |boat|
      sailboat_ids << boat.captain_id
    end

    catamaran = Classification.where(name: 'Motorboat')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

  motorboat_ids = []
    boat.to_a.each do |boat|
      motorboat_ids << boat.captain_id
    end

    motorboat = Captain.where(id: motorboat_ids)
    motorboat.where(id: sailboat_ids)
  end

  def self.non_sailors
    catamaran = Classification.where.not(name: 'Sailboat')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

    captain_ids = []
    boat.to_a.each do |boat|
      captain_ids << boat.captain_id
    end

    catamaran = Classification.where(name: 'Sailboat')
    boat_classification = BoatClassification.where(classification_id: catamaran)

    all_ids = []
    boat_classification.to_a.each do |boat|
      all_ids << boat.boat_id
    end

    boat = Boat.where(id: all_ids)

    sailboat_ids = []
    boat.to_a.each do |boat|
      sailboat_ids << boat.captain_id
    end

    Captain.where.not(id: sailboat_ids)
  end
end
