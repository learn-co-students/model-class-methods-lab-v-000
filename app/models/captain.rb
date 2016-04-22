class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
    self.joins(boats: :classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    #self.includes(boats: :classifications).where("classifications.name = ?", "Sailboat").uniq
    self.joins(boats: :classifications).where("classifications.name = ?", "Sailboat").distinct
  end

  #helper method for talented_seamen
  def self.motorboaters
    self.joins(boats: :classifications).where("classifications.name = ?", "Motorboat").distinct
  end

  def self.talented_seamen
    self.where(id: sailors & motorboaters)
  end

  def self.non_sailors
    self.where.not(id: sailors)
  end

end
