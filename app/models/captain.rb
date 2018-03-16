class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  #<Captain id: 1, name: "Captain Cook", admiral: true, 
  # created_at: "2017-12-15 20:50:47", updated_at: "2017-12-15 20:50:47">\

  def self.catamaran_operators
    joins(:boats).joins(:classifications).where(classifications: {name: "Catamaran"}).distinct
  end

  def self.sailors
    joins(:boats).joins(:classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motormen
    joins(:boats).joins(:classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seamen
    where(id: self.sailors & self.motormen)
  end

  def self.non_sailors
    where(id: self.all-self.sailors)
  end

end
