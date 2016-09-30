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

  end

  def self.non_sailors

  end
end
