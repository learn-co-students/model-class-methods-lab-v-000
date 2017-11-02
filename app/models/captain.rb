class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    where("boat == 'catamaran'")
  end
end
