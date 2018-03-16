class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  scope :with_classifications, -> {self.includes(:classifications)}

  def self.catamaran_operators
    self.with_classifications.where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.with_classifications.group('captains.id').where(classifications: {name: "Sailboat"}).select('captains.id')
  end

  def self.motorboaters
    self.with_classifications.group('captains.id').where(classifications: {name: "Motorboat"}).select('captains.id')
  end

  def self.talented_seamen
    talented_seamen = self.motorboaters.pluck(:id) & self.sailors.pluck(:id)
    self.where("id IN (?)", talented_seamen)
  end

  def self.non_sailors
    sailors = self.sailors.pluck(:id)
    self.where("id NOT IN (?)", sailors)
  end
end
