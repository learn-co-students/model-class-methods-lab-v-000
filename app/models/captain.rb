class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    class_id = Classification.where(name: 'Catamaran')
    #get all boats that are catamarans 
    boat_ids = BoatClassification.where(classification_id: class_id).pluck(:boat_id)
    #get all caps of cat boats
    capt_ids = Boat.where(id: boat_ids).pluck(:captain_id)
    #find all captains 
    all.where(id: capt_ids)
  end

  def self.sailors
    boats = Boat.sailboats.pluck(:captain_id)
    all.where(id: boats)
  end


  def self.talented_seamen
    where("id IN (?)", self.sailors.pluck(:id) & includes(boats: :classifications).where(classifications: {name: "Motorboat"}).pluck(:id))
  end

  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
