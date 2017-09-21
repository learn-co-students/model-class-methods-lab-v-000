class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [:boat_classifications, :classifications]).where("classifications.name = ? ", "Catamaran").distinct
  end

  def self.sailors
    joins(boats: [:boat_classifications, :classifications]).where("classifications.name = ? ", "Sailboat").distinct
  end

  def self.talented_seamen
    joins(boats: [:boat_classifications, :classifications]).where("classifications.name = ? OR classifications.name = ?", "Sailboat", "Motorboat").group("classifications.name").order(:name)
  end

  def self.non_sailors
    sailors = joins(boats: [:boat_classifications, :classifications]).select(:id).where("classifications.name = ?", "Sailboat")
    where("id NOT IN (?)", sailors.pluck(:id))
  end

end
