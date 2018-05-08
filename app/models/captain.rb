class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(:boats).where('classifications.name = ?', 'Catamaran').references(:boats)
  end
end
