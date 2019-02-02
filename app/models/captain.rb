class Captain < ActiveRecord::Base
  has_many :boats


  def self.catamaran_operators
    self.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    self.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboatists
    self.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    id_list = self.sailors.pluck(:id) & self.motorboatists.pluck(:id)
    self.where("id IN (?)", id_list)
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
