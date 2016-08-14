class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    ids = Boat.joins(:classifications).where("classifications.name" => "Catamaran").pluck(:captain_id)
    where(id: ids)
  end

  def self.sailors
    ids = Boat.sailboats.pluck(:captain_id)
    where(id: ids)
  end

  def self.motorboats
    ids = Boat.motorboats.pluck(:captain_id)
    where(id: ids)
  end

  def self.talented_seamen
    arr = motorboats & sailors
    Captain.where(id: arr.map(&:id))
  end

  def self.non_sailors
    arr = Captain.all - sailors
    Captain.where(id: arr.map(&:id))
  end
end
