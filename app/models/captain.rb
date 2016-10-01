class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, :through => :boats

  def self.catamaran_operators
    joins(:classifications).where("classifications.name =?", "Catamaran").uniq
  end

  def self.sailors
    joins(:classifications).where("classifications.name =?", "Sailboat").uniq
  end

  def self.talented_seamen
    where(id: (sailors.to_a & motorboaters.to_a).map(&:id))
  end

  def self.motorboaters
    joins(:classifications).where("classifications.name =?", "Motorboat").uniq
  end

  def self.non_sailors
    where.not(id: sailors.to_a.map(&:id))
  end
end
