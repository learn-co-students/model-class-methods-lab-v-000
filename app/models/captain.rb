require './app/models/boat.rb'

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications]).where('classifications.name = ?', "Catamaran").distinct
  end

  def self.sailors
    Captain.joins(boats: [:classifications]).where('classifications.name = ?', "Sailboat").distinct
    #self.joins(Boat.sailboats)
  end

  def self.motorboaters
    Captain.joins(boats: [:classifications]).where('classifications.name = ?', "Motorboat").distinct
  end

  def self.talented_seafarers
    sailors.where('captains.id IN (?)', motorboaters.pluck('id'))
  end
end
