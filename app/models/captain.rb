class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats).where('boat.name' => "catamaran")
  end
end
