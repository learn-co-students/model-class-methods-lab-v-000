class Captain < ActiveRecord::Base
  has_many :boats
  
  scope :motorboat, -> { joins(boats: [boat_classifications: :classification]).where(classifications: {name: 'Motorboat'}).distinct }
  scope :sailor, -> { joins(boats: [boat_classifications: :classification]).where(classifications: {name: 'Sailboat'}).distinct }
  
  def self.catamaran_operators
    Captain.joins(boats: [boat_classifications: :classification]).where(classifications: {name: 'Catamaran'}).distinct
  end

  def self.motorboat_operators
    Captain.joins(boats: [boat_classifications: :classification]).where(classifications: {name: 'Motorboat'}).distinct
  end
  
  def self.sailors
    Captain.joins(boats: [boat_classifications: :classification]).where(classifications: {name: 'Sailboat'}).distinct
  end
  
  def self.talented_seamen
    Captain.motorboat.where(id: Captain.sailor.pluck(:id) )
  end
  
  def self.non_sailors
    Captain.all.where.not(id: Captain.sailor.pluck(:id)).distinct
  end
  
end
