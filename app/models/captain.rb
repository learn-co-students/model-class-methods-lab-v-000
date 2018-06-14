class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(:classifications).where(classifications: {name: "Catamaran"})
  end

end
