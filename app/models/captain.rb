class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    joins(:boats).joins(:classifications).group('captains.id').where('classifications.name is ?', "Catamaran")
  end

  def self.sailors
    joins(:boats).joins(:classifications).group('captains.id').where('classifications.name is ?', "Sailboat")
  end
  
  def self.motorboaters
    joins(:boats).joins(:classifications).group('captains.id').where('classifications.name is ?', "Motorboat")
  end

  def self.talented_seamen
    sailors.where(id: Captain.motorboaters.pluck(:id))
  end

  def self.non_sailors
    where.not(id: Captain.sailors.pluck(:id))
  end
end
