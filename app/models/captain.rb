class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.includes(:classifications).where('classifications.name = ?', 'Catamaran')
  end

  def self.sailors
    self.uniq.includes(:classifications).where('classifications.name = ?', 'Sailboat')
  end

  def self.motorboaters
    self.uniq.includes(:classifications).where('classifications.name = ?', 'Motorboat')
  end

  def self.talented_seamen
    binding.pry
    sailors

    motorboaters
  end
end
