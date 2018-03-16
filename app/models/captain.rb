class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    joins(:boats, :boat_classifications, :classifications).where("classifications.name == 'Catamaran'").uniq
  end

  def self.sailors
    joins(:boats, :boat_classifications, :classifications).where("classifications.name == 'Sailboat'").uniq
  end

  def self.motorboaters
    joins(:boats, :boat_classifications, :classifications).where("classifications.name == 'Motorboat'").uniq
  end

  def self.talented_seamen

    joins(:boats).where("captains.id in (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id)).uniq
  end

  def self.non_sailors
    joins(:boats).where("captains.id not in (?)", self.sailors.pluck(:id)).uniq
  end
end
