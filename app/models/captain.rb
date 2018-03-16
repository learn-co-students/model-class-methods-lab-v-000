class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # binding.pry
    joins(boats: [:classifications]).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    joins(boats: [:classifications]).where("classifications.name = 'Sailboat'").distinct
  end

  def self.motorboaters
    joins(boats: [:classifications]).where("classifications.name = 'Motorboat'").distinct
  end


  def self.talented_seamen
    sailor_names = self.sailors.joins(boats: [:classifications]).pluck(:name)
    self.where("captains.name = ? OR captains.name = ? OR captains.name = ?", sailor_names[0], sailor_names[1], sailor_names[2]).joins(boats: [:classifications]).where("classifications.name = 'Motorboat'")
  end

  def self.non_sailors
    sailor_names = self.sailors.joins(boats: [:classifications]).pluck(:name)
    self.where.not("captains.name = ? OR captains.name = ? OR captains.name = ?", sailor_names[0], sailor_names[1], sailor_names[2])
  end
end
