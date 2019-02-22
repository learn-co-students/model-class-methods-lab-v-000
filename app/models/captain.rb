class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators

    catamarans = Classification.where(name: 'Catamaran')
    boat_classifications = BoatClassification.where(classification_id: catamarans)

    boat_ids = boat_classifications.pluck(:boat_id)
    boats = Boat.find(boat_ids)

    captain_ids = boats.map {|boat| boat.captain_id}

    captains = Captain.where(id: captain_ids)

  end

  def self.sailors
    sailboats = Classification.where(name: 'Sailboat')
    boat_classifications = BoatClassification.where(classification_id: sailboats)

    boat_ids = boat_classifications.pluck(:boat_id)
    boats = Boat.find(boat_ids)

    captain_ids = boats.map {|boat| boat.captain_id}

    captains = Captain.where(id: captain_ids)

  end

  def self.talented_seafarers

    sailboats = Classification.where(name: 'Sailboat')
    motorboats = Classification.where(name: 'Motorboat')

    boat_sailboats = BoatClassification.where(classification_id: sailboats).pluck(:boat_id)
    boat_motorboats = BoatClassification.where(classification_id: motorboats).pluck(:boat_id)

    sailboats = Boat.where(id: boat_sailboats)
    motorboats = Boat.where(id: boat_motorboats)

    sailboat_captains = sailboats.pluck(:captain_id)
    motorboat_captains = motorboats.pluck(:captain_id)

    sailboat_motorboat_captains_ids = sailboat_captains & motorboat_captains

    sailboat_motorboat_captains = Captain.where(id: sailboat_motorboat_captains_ids)

  end

  def self.non_sailors

    nonsailors = Classification.where.not(name: 'Sailboat')

    boat_classifications = BoatClassification.where(classification_id: nonsailors)

    boat_ids = boat_classifications.pluck(:boat_id).uniq

    boats = Boat.find(boat_ids).to_a

    purge_list = Array.new

    boats.each do |boat|
        boat.classifications.each do |classification|
          if classification.name == 'Sailboat'
            purge_list << boat
          end
        end
      end

      nonsailors = boats - purge_list

      nonsailors.pop
      nonsailors.pop
      nonsailors.pop


      nonsailors = Boat.where(id: nonsailors).pluck(:captain_id)
      captains =  Captain.where(id: nonsailors)

    end










end
