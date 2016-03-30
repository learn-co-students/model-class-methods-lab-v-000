class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorists
    all.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
    where("id in (?)", self.sailors.pluck(:id) & self.motorists.pluck(:id))
  end

  def self.non_sailors
    where.not("id in (?)", self.sailors.pluck(:id))
  end


end
