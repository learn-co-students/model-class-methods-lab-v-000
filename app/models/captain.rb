class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.where(id: Boat.x_captains("Catamaran"))
  end

  def self.sailors
    self.where(id: Boat.x_captains("Sailboat"))
  end

  def self.motoboat
    self.where(id: Boat.x_captains("Motorboat"))
  end

  def self.talented_seamen
    ids = self.sailors.pluck(:id)
    self.motoboat.where(id: ids)
  end

  def self.non_sailors
    self.where.not(id: self.sailors.pluck(:id))
  end

end
