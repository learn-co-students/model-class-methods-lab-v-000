class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    captains_of_boats("Catamaran")
  end

  def self.sailors
    captains_of_boats("Sailboat")
  end

  def self.motorboaters
    captains_of_boats("Motorboat")
  end

  def self.talented_seamen
    where("id IN(?)", sailors.select(:id) & motorboaters.select(:id))
  end

  def self.non_sailors
    where.not("id IN(?)", sailors.select(:id))
  end

  private

  def self.captains_of_boats(type)
    joins(boats: [:classifications]).where({classifications: {name: type}}).uniq
  end

end
