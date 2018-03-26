class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators
    self.joins(:classifications).where("classifications.name == ?", "Catamaran")
  end

end
