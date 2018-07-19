class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
      binding.pry
    #   self.joins(:boats).group('boats.classifications').where('classification.name = ?', "catamaran")
  end
end
