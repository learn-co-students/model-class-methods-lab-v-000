class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  	includes(boats: :classifications).where(["classifications.name = ?", "Catamaran"]).uniq
  end

  def self.sailors
  	includes(boats: :classifications).where(["classifications.name = ?", "Sailboat"]).uniq
  end

  def self.motorboaters
  	includes(boats: :classifications).where(["classifications.name = ?", "Motorboat"]).uniq
  end

  def self.talented_seamen
  	where(id: sailors.pluck(:id) & motorboaters.pluck(:id))
  	# includes(boats: :classifications).find_by("classifications.name" => ["Sailboat","Motorboat"])

  	# includes(boats: :classifications).where(classifications: {name: ["Sailboat", "Motorboat"]}).uniq
  end

  def self.non_sailors
  	where.not("id IN (?)", sailors.pluck(:id))
  end

end
