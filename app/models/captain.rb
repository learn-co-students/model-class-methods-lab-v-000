require 'pry'
class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where('classifications.name' => "Catamaran")
  end

  def self.sailors
    joins(boats: :classifications).where('classifications.name' => "Sailboat").distinct
  end

  def self.talented_seamen
    sailboat = sailors.pluck(:id)
    motorboat = joins(boats: :classifications).where('classifications.name' => "Motorboat").distinct.pluck(:id)
    both = sailboat & motorboat
    where(id: both)
  end

  def self.non_sailors
    where.not(id: sailors.pluck(:id))
  end
end






