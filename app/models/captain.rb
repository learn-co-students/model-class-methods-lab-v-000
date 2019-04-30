class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boat: :classifications).where(classifications: {name: "Catamaran"})
  end
end
