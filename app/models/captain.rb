class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    # Captain.includes(boats: :classifications).where(classifications: {name: "Sailboat"} && classifications: {name: "Motorboat"}).distinct
    Captain.includes(boats: :classifications).where('classifications.name = ?, ?', "Sailboat", "Motorboat").distinct
  end

end
