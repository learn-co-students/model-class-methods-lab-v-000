class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # where("boats == ?", 'Catamaran')
  end
end
