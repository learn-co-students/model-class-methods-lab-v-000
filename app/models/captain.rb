class Captain < ActiveRecord::Base
  has_many :boats
  has_many :boat_classifications, through: :boats
  has_many :classifications, through: :boat_classifications

  def self.catamaran_operators # returns all captains of catamarans
    self.joins(:classifications).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors # returns captains with sailboats
    self.joins(:classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboaters
    self.joins(:classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen # returns captains of motorboats and sailboats
    self.where('id IN (?)', self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors # returns people who are not captains of sailboats
    self.where.not('id IN (?)', self.sailors.pluck(:id))
  end
end
