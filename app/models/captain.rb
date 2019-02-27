class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:classification).where("classification.name = 'Catamaran'")

  end
end
