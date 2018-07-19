class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      binding.pry
     
      # Select all Captains
      #where boats.classifications.name = catamaran
  end
end
