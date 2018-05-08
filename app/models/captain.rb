class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.includes(:boats).where('boats.classifications.name = ?', 'Catamaran').references(:boats)
  end
end
