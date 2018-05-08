class Captain < ActiveRecord::Base
  has_many :boats

  def catamaran_operators
    byebug
    self.includes(:boats).where('boats.classifications = ?', 'catamaran').references(:boats)
  end
end
