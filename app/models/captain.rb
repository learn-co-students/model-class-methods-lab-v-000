class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    #self.where
  end
end
