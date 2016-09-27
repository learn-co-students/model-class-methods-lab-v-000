class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.includes(boats: :classifications).where("classifications.name = ?", "Sailboat").group(:captain_id)
  end

  def self.motorboaters
    self.includes(boats: :classifications).where("classifications.name = ?", "Motorboat").group(:captain_id)
  end

  def self.talented_seamen
    self.where("name IN (?)", self.sailors.pluck(:name) & self.motorboaters.pluck(:name))
  end

  def self.non_sailors
    self.where("name NOT IN (?)", self.sailors.pluck(:name))
  end

end
