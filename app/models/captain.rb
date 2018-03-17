class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(boats: :classifications).where('classifications.name = ?', 'Catamaran').uniq
  end

  def self.sailors
    self.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboats
    self.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen
    ids = self.sailors.pluck(:id) & self.motorboats.pluck(:id)
    self.where(id: ids)
  end

  def self.non_sailors
    ids = self.sailors.pluck(:id)
    self.where.not(id: ids)
  end

end
