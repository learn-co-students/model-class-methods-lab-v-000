class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:boat_classifications, :classifications).where( "classifications.name = ?", "Catamaran").distinct
    captains = boats.map {|boat| boat.captain}
  end

  def self.sailors
    boats = Boat.joins(:boat_classifications, :classifications).where( "classifications.name = ?", "Sailboat").distinct
    captains = boats.map {|boat| boat.captain}.compact
  end

end
