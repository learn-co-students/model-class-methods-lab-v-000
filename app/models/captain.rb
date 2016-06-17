class Captain < ActiveRecord::Base
  has_many :boats

  def self.boat_class(classname)
  	Boat.joins(:classifications).where( classifications: { :name => classname } )
  end

  def self.captain_id_extractor(boats)
  	boats.map { |boat| boat.captain_id }
  end
  
  def self.catamaran_operators
  	@boats = captain_id_extractor(boat_class("Catamaran"))
  	Captain.joins(:boats).distinct.where(boats: { captain_id: [@boats]})
  end

  def self.sailors
  	@boats = captain_id_extractor(boat_class("Sailboat"))
  	Captain.joins(:boats).distinct.where(boats: { captain_id: [@boats]})
  end

  def self.talented_seamen
  	@motorboats = captain_id_extractor(boat_class("Motorboat"))
  	@sailboats = captain_id_extractor(boat_class("Sailboat"))
  	@boats = @motorboats & @sailboats
  	Captain.joins(:boats).distinct.where(boats: { captain_id: [@boats]})
  end

  def self.non_sailors
  	@all = captain_id_extractor(Boat.all)
  	@sailboats = captain_id_extractor(boat_class("Sailboat"))
  	@boats = @all - @sailboats
  	Captain.joins(:boats).distinct.where(boats: { captain_id: [@boats]})
  end

end
