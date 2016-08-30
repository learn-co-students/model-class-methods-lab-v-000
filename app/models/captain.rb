class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
  end


  def self.sailors
    Captain.where(self.boat.classification.include?("catamaran"))
  end


end
