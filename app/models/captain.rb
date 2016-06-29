class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.includes(:classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(:classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.talented_seamen
    sailor_ids = self.sailors.pluck(:id)
    motorboat_ids = self.motorboats.pluck(:id)
    ids = sailor_ids & motorboat_ids
    self.where(id: ids)
  end

  def self.motorboats
    self.includes(:classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.non_sailors
     sailor_ids = self.sailors.pluck(:id)
     all_ids = self.all.pluck(:id)
     ids = all_ids - sailor_ids
     self.where(id: ids)
  end
end

# Captain.includes(:classifications).where(classifications: {name: "Sailboat"}).uniq & Captain.includes(:classifications).where(classifications: {name: "Motorboat"}).uniq
