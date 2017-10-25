class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    Captain.includes(:classifications).where('classifications.name = ?', 'Catamaran').references(:classifications)
  end

  def self.sailors
    Captain.includes(:classifications).where('classifications.name = ?', 'Sailboat').references(:classifications).uniq
  end

  def self.talented_seamen
    Captain.includes(:classifications).where('classifications.name = ?', 'Motorboat' && 'Sailboat').references(:classification).uniq
  end

end
