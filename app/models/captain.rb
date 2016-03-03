class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    binding.pry

  end

  def self.sailors

  end

  def self.talented_seamen

  end

  def self.non_sailors

  end
end
