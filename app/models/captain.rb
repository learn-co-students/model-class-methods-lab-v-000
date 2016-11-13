class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
  Captain.joins(:boats => :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
   Captain.joins(:boats => :classifications).where(classifications: {name: "Sailboat"}).uniq
  end
  
  def self.motorboats
   Captain.joins(:boats => :classifications).where(classifications: {name: "Motorboat"}).uniq
  end

  def self.talented_seamen
  self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboats.pluck(:id))
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end
end
