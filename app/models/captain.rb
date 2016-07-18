class Captain < ActiveRecord::Base
  has_many :boats
	
	def self.catamaran_operators
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Catamaran').uniq
  end

  def self.sailors
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboats
    Captain.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen
    ids = Captain.sailors.pluck(:id) & Captain.motorboats.pluck(:id)
    Captain.where(id: ids)
  end

  def self.non_sailors
    ids = Captain.sailors.pluck(:id)
    Captain.where.not(id: ids)
  end
end
