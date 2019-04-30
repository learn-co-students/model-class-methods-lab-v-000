class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    
    Captain.joins(boats: :classifications).where(classifications: {name: "Sailboat"})
  end
end
