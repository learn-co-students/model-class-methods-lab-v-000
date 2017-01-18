class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [boat_classifications: :classification]).where('classifications.name = "Catamaran"')
  end

  def self.sailors
    joins(boats: [boat_classifications: :classification]).where('classifications.name = "Sailboat"').distinct
  end

  def self.talented_seamen
     joins(boats: [boat_classifications: :classification]).where('classifications.name = "Sailboat" AND classifications.name = "Motorboat"')
   end

end
