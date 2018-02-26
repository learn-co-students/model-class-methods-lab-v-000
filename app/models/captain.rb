class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captain_ids = Boat.boats_of_a_kind("Catamaran").pluck(:captain_id)
    where('id IN (?)', captain_ids)
  end

  def self.sailors
    # captain_ids = Boat.sailboats.pluck(:captain_id)
    captain_ids = Boat.sailboats.where.not('captain_id' => nil).pluck(:captain_id)
    where('id IN (?)', captain_ids)
  end

  def self.talented_seafarers
    captain_sailboat = Boat.sailboats.where.not('captain_id' => nil).pluck(:captain_id)
    captain_motorboat = Boat.boats_of_a_kind("Motorboat").where.not('captain_id' => nil).pluck(:captain_id).flatten
    captain_ids = captain_sailboat & captain_motorboat
    where('id IN (?)', captain_ids)
  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    where('id not IN (?)', sailor_ids)
  end
end
