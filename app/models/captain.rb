class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name == ?", "Catamaran")
  end

  def self.sailors
    self.joins(:classifications).where("classifications.name == ?", "Sailboat").group("captain_id")
  end

  def self.talented_seafarers
    self.joins(:classifications).where("classifications.name == ?", "Sailboat").or(self.joins(:classifications).where("classifications.name == ?", "Motorboat")).group("captain_id")
  end
end
