class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.join(boat: :classifications).where(classifications: {name: "Catamaran"})
  end
end
