class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:boats).catamarans
  end

end
