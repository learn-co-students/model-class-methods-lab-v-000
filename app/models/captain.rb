class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(:boats).where(boats.classifications: {name: "Catamaran"})
  end
end
