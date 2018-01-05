class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats # I added

  def self.catamaran_operators
    Captain.joins(:classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    Captain.joins(:classifications).where("classifications.name = ?", "Sailboat").uniq
  end


  def self.motorboats
    Captain.joins(:classifications).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seamen
    # Captain.joins(:classifications).where("classifications.name = ? AND classifications.name = ?", "Motorboat", "Sailboat").uniq
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    # Captain.joins(:classifications).where.not("classifications.name = ?", "Sailboat").uniq
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
