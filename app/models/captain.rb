class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    binding.pry
    self.all.each do |captain|

    end

  end
end
