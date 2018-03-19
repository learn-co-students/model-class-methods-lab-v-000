class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    binding.pry
    self.joins(:classifications).group('captain.id').where("classifications.name = Catamaran")
  end
end
