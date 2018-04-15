class Captain < ActiveRecord::Base
  has_many :boats
  def self.non_sailors #captains who don't have a sailboat (where the classification's name of the boat isnt a sailboat)

  end
  def self.sailors
  end
end
