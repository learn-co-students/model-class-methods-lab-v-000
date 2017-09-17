class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    binding.pry
  end

end
