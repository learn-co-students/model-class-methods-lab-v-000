class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: [:classifications]).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    joins(boats: [:classifications]).where("classifications.name = ?", "Sailboat").distinct
  end

  def self.talented_seamen
    mb_ids = self.joins(boats: [:classifications]).where("classifications.name = ?", "Motorboat").pluck(:id)

    self.sailors.where(id: mb_ids)
  end

  def self.non_sailors
    non_sailor_ids = self.all.pluck(:id) - self.sailors.pluck(:id)

    where(id: non_sailor_ids)
  end

end
