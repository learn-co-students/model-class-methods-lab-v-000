class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
    all.includes(boats: :classifications).where('classifications.name = ?', 'Sailboat').uniq
  end

  def self.motorboaters
    all.includes(boats: :classifications).where('classifications.name = ?', 'Motorboat').uniq
  end

  def self.talented_seamen
    all.where('id IN (?)', self.motorboaters.pluck(:id)).where('id IN (?)', self.sailors.pluck(:id))
  end

  def self.non_sailors
    all.where('id NOT IN (?)', self.sailors.pluck(:id))
  end
end
  
