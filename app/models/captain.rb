class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    Captain.joins(boats: [:classifications]).where('classifications.name = ?', "Catamaran").distinct
  end

  def self.sailors
    Captain.joins(boats: [:classifications]).where('classifications.name = ?', "Sailboat").distinct
  end

  def self.motorboaters
    Captain.joins(boats: [:classifications]).where('classifications.name = ?', "Motorboat").distinct
  end

  def self.talented_seafarers
    # get captains who
    # 1, are in charge of a motorboat, AND
    # 2, are in charge of a sailboat
=begin
  # this produces the correct result set, but as an Array, which does not respond to .pluck? and so fails the spec
  sailors.merge(motorboaters)
  all_sailors = self.sailors
  all_motorboaters = self.motorboaters

  sailors.select do |sailor|
    motorboaters.include?(sailor)
  end
=end
  end
end
