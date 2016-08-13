class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.table
    Captain.arel_table
  end

  def self.catamaran_operators
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where(classifications: {name: 'Catamaran'}).group('captains.id')
  end

  def self.sailors
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where(classifications: {name: 'Sailboat'}).group('captains.id')
  end

  def self.motorboaters
    self.joins(:boats).joins(:boat_classifications).joins(:classifications).where(classifications: {name: 'Motorboat'}).group('captains.id')
  end


  def self.talented_seamen
    where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where('id NOT IN (?)', self.sailors.pluck(:id))
  end
end
