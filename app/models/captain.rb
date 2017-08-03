class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [boat_classifications: :classification]).where('classifications.name = "Catamaran"')
  end

  def self.sailors
    joins(boats: [boat_classifications: :classification]).where('classifications.name = "Sailboat"').distinct
  end

  def self.talented_seamen
    motorboats.where(id: sailors)
  end

   def self.motorboats
     joins(boats: [boat_classifications: :classification]).where('classifications.name = "Motorboat"').distinct
   end

   def self.non_sailors
     where.not(id: sailors)
   end
end
