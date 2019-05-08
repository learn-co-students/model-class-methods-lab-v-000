class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    input = Boat.catamarans.pluck(:captain_id)
    Captain.where(id: input)
  end

  def self.sailors
    input = Boat.sailboats.pluck(:captain_id)
    Captain.where(id: input)
  end

  def self.talented_seamen #motorboats and sailboats
    input = Boat.talented
    Captain.where(id: input)
  end

  def self.non_sailors
    Captain.where.not(id: Captain.sailors.pluck(:id))
  end
end
