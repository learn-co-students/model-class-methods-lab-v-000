class Captain < ActiveRecord::Base
  has_many :boats
  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name:"Catamaran"}).distinct
  end
  def self.sailors
    includes(boats: :classifications).where(classifications: {name:"Sailboat"}).distinct
  end
  def self.talented_seafarers
    Captain.includes(boats: :classifications).where("classifications.name" => ["Sailboat","Motorboat"])
  end
end
