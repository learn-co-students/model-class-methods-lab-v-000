class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: [:classifications])
        .where({classifications: {name: "Catamaran"} })
  end

  def self.sailors
    self.joins(boats: [:classifications])
        .where({classifications: {name: "Sailboat"} })
        .distinct
  end

  def self.talented_seamen
    seamen = self.sailors.pluck(:id) & self.joins(boats: [:classifications]).where(classifications: {name: "Motorboat"}).pluck(:id)
    self.where(id: seamen)
  end

  def self.non_sailors
    sailors = self.sailors.pluck(:id)
    self.where.not(id: sailors)
  end
end
