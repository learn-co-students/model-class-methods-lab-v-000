class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats).where(:classifications => {name: "Catamaran"})
  end
end
