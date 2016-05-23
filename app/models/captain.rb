class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.all.joins(boats: :classifications).where(classifications: { name: "Catamaran" })
  end

  def self.sailors
    self.all.joins(boats: :classifications).where(classifications: { name: "Sailboat" }).uniq
  end

  def self.motorboaters
    self.all.joins(boats: :classifications).where(classifications: { name: "Motorboat" }).uniq
  end

  def self.talented_seamen
    self.all.where("id in (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    self.all.where.not("id in (?)", self.sailors.pluck(:id))
  end
end
