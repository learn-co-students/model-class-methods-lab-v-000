class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    includes(:classifications).where('classifications.name = ?', 'Catamaran').references(:classifications)
  end

  def self.sailors
    includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications).uniq
  end

  def self.motorbotors
    includes(:classifications).where('classifications.name = ?', 'Motorboat').references(:classifications).uniq
  end

  def self.talented_seafarers
    sailors = self.sailors.pluck(:id)
    motorbotors = self.motorbotors.pluck(:id)
    talented_ids = sailors & motorbotors
    Captain.all.where(id: talented_ids)
  end

  def self.non_sailors
    captain_ids = Captain.all.pluck(:id) - self.sailors.pluck(:id)
    Captain.all.where(id: captain_ids)
  end
end
